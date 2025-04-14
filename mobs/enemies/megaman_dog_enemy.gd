extends "default_enemy.gd"

var turn_time: float
var last_turn: float

func _ready() -> void:
	turn_time = randf_range(0.1, 2.0)
	last_turn = Time.get_unix_time_from_system()
	direction = Vector2.RIGHT
	health = 3
	speed = 450
	
func _process(_delta: float) -> void:
	var now_time: float = Time.get_unix_time_from_system()
	if now_time - last_turn > turn_time:
		direction = direction.rotated(PI/2)
		last_turn = now_time
		turn_time = randf_range(0.1, 2.0)
