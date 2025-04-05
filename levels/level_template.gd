extends Node2D

signal level_complete

@export var time_between_enemies: float = 1.0

var start_time: float
var last_enemy: float
var already_ended_level: bool = false
var leaving = false

var Enemy = preload("res://mobs/enemies/default_enemy.tscn")
var enemy_array: Array[Node]

var Player_scene = preload("res://mobs/player/player.tscn")
var player: Node

func _ready() -> void:
	start_time = Time.get_unix_time_from_system()
	last_enemy = 0.0
	if !get_node("player"):
		print(str(name) + " made a player")
		player = Player_scene.instantiate()
		player.position = Vector2(400,400)
		add_child(player)

func _process(_delta: float) -> void:
	if is_level_complete():
		if !already_ended_level:
			end_level()
	else:
		spawn_enemies()

# spawns one enemy of type stored in Enemy if conditions are met
# called each frame
# reimplement for a level if you want to spawn more (or different) enemies at a time
func spawn_enemies() -> void:
	if should_i_spawn_enemies():
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


func _on_top_exit_body_entered(body: Node2D) -> void:
	if !leaving:
		leaving = true
		print("OKAY " + name + " IM LEAVING")
		get_node("exits/top_exit").monitoring = false # turn off get to prevent double moving
		body.process_mode = Node.PROCESS_MODE_DISABLED
		var next_level = load("res://levels/level_template.tscn").instantiate()
		player.reparent(next_level, true)
		get_tree().root.add_child(next_level)
	


func _on_right_exit_body_entered(body: Node2D) -> void:
	pass # Replace with function body.


func _on_bottom_exit_body_entered(body: Node2D) -> void:
	pass # Replace with function body.


func _on_left_exit_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
