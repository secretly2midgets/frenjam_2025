extends Node2D

signal level_complete
var start_time: float
var last_enemy: float
var Enemy = preload("res://mobs/enemies/default_enemy.tscn")

func _ready() -> void:
	start_time = Time.get_unix_time_from_system()
	last_enemy = 0.0

func _process(delta: float) -> void:
	var now_time: float = Time.get_unix_time_from_system()
	
	if now_time - start_time > 50:
		level_complete.emit()
	elif now_time - last_enemy > 1.0:
		var e = Enemy.instantiate()
		add_child(e)
		last_enemy = now_time
