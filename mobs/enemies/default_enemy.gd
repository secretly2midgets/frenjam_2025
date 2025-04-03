extends RigidBody2D

@export var speed: float = 200
var direction: Vector2

func _ready() -> void:
	direction = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0))

func _physics_process(delta: float) -> void:
	move_and_collide(direction*speed*delta)
