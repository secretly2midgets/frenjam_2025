extends CharacterBody2D

@export var speed = 800

func start(in_position: Vector2, in_direction: Vector2) -> void:
	position = in_position + 50*in_direction
	velocity = speed*in_direction
	
func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		queue_free()
