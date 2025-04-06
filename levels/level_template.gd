extends Node2D

signal level_complete

@export var time_between_enemies: float = 1.0
@export var scrolling_speed: float = 200

var level_size:= Vector2(800, 800)

var start_time: float
var last_enemy: float

var already_ended_level: bool = false
var leaving: bool = false
var level_started: bool = true # determine whether or not to start spawning enemies yet.  defaults true for level 1
var scrolling_direction := Vector2(0,0)

var Enemy = preload("res://mobs/enemies/default_enemy.tscn")
var enemy_array: Array[Node]

var Player_scene = preload("res://mobs/player/player.tscn")
var player: Node

var next_level_scene = load("res://levels/test_level.tscn")

# ready runs when the scene is added to the tree
func _ready() -> void:
	start_time = Time.get_unix_time_from_system()
	last_enemy = 0.0
	# this is basically a check to see if this is the first scene in the game or not
	# we do it like this because we want to hand off the player from scene to scene in
	# all cases except for the first
	if !get_node_or_null("player"):
		print(str(name) + " made a player")
		player = Player_scene.instantiate()
		player.position = level_size/2
		add_child(player)

func _process(_delta: float) -> void:
	if is_level_complete():
		if !already_ended_level:
			end_level()
	else:
		spawn_enemies()
		
	# this controls the scroll off the screen to the new level
	if scrolling_direction != Vector2.ZERO:
		position += scrolling_direction*_delta*scrolling_speed
		if leaving:
			if position.x > level_size.x or position.y > level_size.y:
				queue_free()  # delete the old level if it's all the way off screen
		# initialize the new level when it gets to the right spot
		elif abs(scrolling_direction.dot(position)) < scrolling_speed*_delta:
			scrolling_direction = Vector2.ZERO
			position = Vector2.ZERO
			get_node("player").process_mode = Node.PROCESS_MODE_INHERIT
			get_node("walls/right/gate").visible = true
			get_node("walls/left/gate").visible = true
			get_node("walls/top/gate").visible = true
			get_node("walls/bottom/gate").visible = true
			level_started = true
			start_time = Time.get_unix_time_from_system()
		# move the player so they end up in the middle of the level by the time the level is in position
		else:
			get_node("player").position += -scrolling_direction*_delta*scrolling_speed/2

# spawns one enemy of type stored in Enemy if conditions are met
# called each frame
# reimplement for a level if you want to spawn more (or different) enemies at a time
func spawn_enemies() -> void:
	if should_i_spawn_enemies() and level_started:
		var e = Enemy.instantiate()
		add_child(e)
		enemy_array.append(e)
		last_enemy = Time.get_unix_time_from_system()

# determine whether to spawn enemies
# called each frame
# reimplement for each level with specific conditions
# TODO maybe return which enemies to spawn specifically? 
func should_i_spawn_enemies() -> bool:
	return false

# determines if the level has been won
# called each frame
# reimplement for each level with specific conditions
func is_level_complete() -> bool:
	return false 

# emits the level complete signal and kills all remaining enemies
func end_level() -> void:
	level_complete.emit()
	for enemy in enemy_array:
		if enemy:
			enemy.queue_free()
	already_ended_level = true

# ============================================================================
# exit zone functions below, they're all the same except for direction
# TODO make these one function with different inputs

func _on_top_exit_body_entered(body: Node2D) -> void:
	if !leaving:
		leaving = true
		scrolling_direction = Vector2.DOWN
		
		# do some stuff to protect the state
		get_node("exits/top_exit").set_deferred("monitoring", false)  # turn off get to prevent double moving
		body.process_mode = Node.PROCESS_MODE_DISABLED # freeze the player
		
		# load the new level and hand player to it, then add new level to the tree
		var next_level = next_level_scene.instantiate()
		next_level.position = Vector2.UP*level_size  # have to move new level before reparenting player
		get_node("player").reparent(next_level, true)
		get_tree().root.call_deferred("add_child", next_level)
		next_level.scrolling_direction = scrolling_direction
		next_level.get_node("walls/bottom/gate").visible = false
		next_level.level_started = false

func _on_right_exit_body_entered(body: Node2D) -> void:
	if !leaving:
		leaving = true
		scrolling_direction = Vector2.LEFT
		
		# do some stuff to protect the state
		get_node("exits/right_exit").set_deferred("monitoring", false)  # turn off get to prevent double moving
		body.process_mode = Node.PROCESS_MODE_DISABLED # freeze the player
		
		# load the new level and hand player to it, then add new level to the tree
		var next_level = next_level_scene.instantiate()
		next_level.position = Vector2.RIGHT*level_size  # have to move new level before reparenting player
		get_node("player").reparent(next_level, true)
		get_tree().root.call_deferred("add_child", next_level)
		next_level.scrolling_direction = scrolling_direction
		next_level.get_node("walls/left/gate").visible = false
		next_level.level_started = false

func _on_bottom_exit_body_entered(body: Node2D) -> void:
	if !leaving:
		leaving = true
		scrolling_direction = Vector2.UP
		
		# do some stuff to protect the state
		get_node("exits/bottom_exit").set_deferred("monitoring", false)  # turn off get to prevent double moving
		body.process_mode = Node.PROCESS_MODE_DISABLED # freeze the player
		
		# load the new level and hand player to it, then add new level to the tree
		var next_level = next_level_scene.instantiate()
		next_level.position = Vector2.DOWN*level_size  # have to move new level before reparenting player
		get_node("player").reparent(next_level, true)
		get_tree().root.call_deferred("add_child", next_level)
		next_level.scrolling_direction = scrolling_direction
		next_level.get_node("walls/top/gate").visible = false
		next_level.level_started = false

func _on_left_exit_body_entered(body: Node2D) -> void:
	if !leaving:
		leaving = true
		scrolling_direction = Vector2.RIGHT
		
		# do some stuff to protect the state
		get_node("exits/left_exit").set_deferred("monitoring", false)  # turn off get to prevent double moving
		body.process_mode = Node.PROCESS_MODE_DISABLED # freeze the player
		
		# load the new level and hand player to it, then add new level to the tree
		var next_level = next_level_scene.instantiate()
		next_level.position = Vector2.LEFT*level_size  # have to move new level before reparenting player
		get_node("player").reparent(next_level, true)
		get_tree().root.call_deferred("add_child", next_level)
		next_level.scrolling_direction = scrolling_direction
		next_level.get_node("walls/right/gate").visible = false
		next_level.level_started = false
