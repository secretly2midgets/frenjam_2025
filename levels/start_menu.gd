extends Node2D

var first_level 

func _ready() -> void:
	first_level = preload("res://levels/test_level.tscn")

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(first_level)
