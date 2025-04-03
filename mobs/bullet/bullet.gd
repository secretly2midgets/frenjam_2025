extends CharacterBody2D

@export var speed = 800

# IDEAS FOR BULLET TYPES
#  - bullet that bounces off walls and lives for a certain amount of time
#  - triple shot
#  - bullet that can go through multiple enemies
#  - fast bullet
#  - bullet that explodes into multiple bullets
#  - bullet that explodes into AoE in general
#  - bullet with curved path
#  - bullet that seeks enemies

func start(in_position: Vector2, in_direction: Vector2, offset: float) -> void:
	$animated_bone.play()
	position = in_position + offset*in_direction
	velocity = speed*in_direction
	
func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		queue_free()
