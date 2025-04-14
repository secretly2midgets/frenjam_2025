extends CharacterBody2D

@export var isGate: bool = false
@export var gate_side: String

func _on_level_end(level_pos) -> void:
	if isGate and (gate_side in WorldMap.get_valid_directions(level_pos)):
		queue_free()
