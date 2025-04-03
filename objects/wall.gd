extends StaticBody2D

@export var isGate: bool = false

func _on_level_end() -> void:
	if isGate:
		visible = false
