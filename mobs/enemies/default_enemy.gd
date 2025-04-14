extends CharacterBody2D

# ENEMY IDEAS
# - Enemy that moves in square around map
# - Enemy that seeks player directly (undertale dog)
# - Random walk enemy
# - Enemy that flees/avoids bullets
# - Enemy that hides in corner and shoots you (megaman dog)

@export var speed: float = 200
var direction: Vector2
var health: int = 1

func _ready() -> void:
	direction = Vector2.RIGHT.rotated(randf_range(0, 2.0*PI))
	$Sprite2D.play()

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(speed * direction * delta)
	
	if direction.x > 0:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false
	
	if collision:
		var hit_layer = collision.get_collider().get_collision_layer()
		if (hit_layer & 0b1 == 0b1) || (hit_layer & 0b1000 == 0b1000): # wall or other enemy
			direction = direction.bounce(collision.get_normal()) 
		elif hit_layer & 0b100 == 0b100: # bullet
			health -= 1
			if health <= 0:
				get_parent().kill_count += 1
				queue_free()
