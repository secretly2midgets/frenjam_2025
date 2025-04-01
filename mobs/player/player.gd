extends CharacterBody2D

@export var move_speed = 200
var Bullet = preload("res://mobs/bullet/bullet.tscn")
var fire_rate: float = 0.1 # number of seconds between bullets
var last_shot: float = 0.0

func shoot(shoot_direction: Vector2) -> void:
	var current_time := Time.get_unix_time_from_system()
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
	move_and_collide(velocity*delta)
