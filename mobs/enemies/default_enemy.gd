extends CharacterBody2D

# ENEMY IDEAS
# - Enemy that moves in square around map
# - Enemy that seeks player directly (undertale dog)
# - Random walk enemy
# - Enemy that flees/avoids bullets
# - Enemy that hides in corner and shoots you (megaman dog)

@export var speed: float = 200
var direction: Vector2

func _ready() -> void:
	direction = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0))

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(speed * direction * delta)
	if collision:
		collision_layer = collision.get_collider().get_collision_layer()
		if collision_layer & 0b1 == 0b1: # wall
			direction = direction.bounce(collision.get_normal()) 
		elif collision_layer & 0b100 == 0b100: # bullet
			queue_free()
