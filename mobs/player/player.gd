extends CharacterBody2D

@export var move_speed = 200
var Bullet = preload("res://mobs/bullet/bullet.tscn")

func shoot(shoot_direction: Vector2) -> void:
	var b = Bullet.instantiate()
	b.start(global_position, shoot_direction)
	get_tree().root.add_child(b)

func get_input() -> void:
	var input_direction: Vector2 = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = input_direction * move_speed
	var shoot_direction: Vector2 = Input.get_vector("shoot_left","shoot_right","shoot_up","shoot_down")
	if shoot_direction.length() > 0:
		shoot(shoot_direction)

func _physics_process(delta: float) -> void:
	get_input()
	move_and_collide(velocity*delta)
