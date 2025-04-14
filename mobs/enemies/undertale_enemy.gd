extends "default_enemy.gd"

func _process(_delta: float) -> void:
	direction = position.direction_to(get_parent().get_node("player").position)
