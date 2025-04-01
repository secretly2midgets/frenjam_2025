extends CharacterBody2D

@export var speed = 800

func start(in_position: Vector2, in_direction: Vector2, offset: float) -> void:
	position = in_position + offset*in_direction
	velocity = speed*in_direction
	
func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		queue_free()
