extends Control

var health_3 = preload("res://mobs/player/3_health.png")
var health_2 = preload("res://mobs/player/2_health.png")
var health_1 = preload("res://mobs/player/1_health.png")
var health_0 = preload("res://mobs/player/0_health.png")

func set_health(value: int):
	if value == 3:
		$healthSprite.texture = health_3
	elif value == 2:
		$healthSprite.texture = health_2
	elif value == 1:
		$healthSprite.texture = health_1
	else:
		$healthSprite.texture = health_0
