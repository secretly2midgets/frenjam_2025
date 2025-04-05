extends Node2D

signal level_complete
var start_time: float

func _ready() -> void:
	start_time = Time.get_unix_time_from_system()

func _process(_delta: float) -> void:
	var now_time: float = Time.get_unix_time_from_system()
	
	if now_time - start_time > 5:
		level_complete.emit()
