extends CharacterBody2D

#Preloading the sprites
var front_sprite = preload("res://mobs/player/player_front.png")
var front_side_sprite = preload("res://mobs/player/player_front_side.png")
var side_sprite = preload("res://mobs/player/player_side.png")
var back_side_sprite = preload("res://mobs/player/player_back_side.png")
var back_sprite = preload("res://mobs/player/player_back.png")

#Health related
@export var health = 3
@onready var invunerability_timer = $invulnerability_timer
@onready var effects_animation = $effects_animation

@export var move_speed = 200
var Bullet = preload("res://mobs/bullet/bullet.tscn")
var fire_rate: float = 0.1 # number of seconds between bullets
var last_shot: float = 0.0

func shoot(shoot_direction: Vector2) -> void:
	var current_time := Time.get_unix_time_from_system()
	change_sprite(shoot_direction)
	if current_time - last_shot > fire_rate:
		var b = Bullet.instantiate()
		b.start(global_position, shoot_direction, 50*(abs(shoot_direction.x) + abs(shoot_direction.y)))
		get_tree().root.add_child(b)
		last_shot = current_time

func get_input() -> void:
	var input_direction: Vector2 = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = input_direction * move_speed
	var shoot_direction: Vector2 = Input.get_vector("shoot_left","shoot_right","shoot_up","shoot_down")
	if shoot_direction.length() > 0:
		shoot(shoot_direction)

func _physics_process(delta: float) -> void:
	get_input()
	var collision = move_and_collide(velocity*delta)
	if collision:
		if collision_layer & 0b10000 == 0b10000: #Hit by enemy
			health -= 1
			if health < 0: #Player dies if they hit 0 health
				queue_free()
			else:
				effects_animation.play("flash")
				effects_animation.queue("flash")
				position = Vector2(400,400) # move back to the center

func change_sprite(shoot_direction: Vector2) -> void:
	if shoot_direction[0] == 0:
		if shoot_direction[1] > 0:
			$Sprite2D.texture = front_sprite
		elif shoot_direction[1] < 0:
			$Sprite2D.texture = back_sprite
	else:
		if shoot_direction[1] > 0:
			$Sprite2D.texture = front_side_sprite
		elif shoot_direction[1] < 0:
			$Sprite2D.texture = back_side_sprite
		else:
			$Sprite2D.texture = side_sprite
	$Sprite2D.flip_h = shoot_direction[0] < 0

func _on_invulnerability_timer_timeout() -> void:
	# Turns off the blinking
	effects_animation.play("rest")
