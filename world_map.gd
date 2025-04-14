extends Node

var world_map
var visited_worlds: Array[Vector2i]

# returns a list of directions which are possible to travel from the current spot
func get_valid_directions(level_pos: Vector2i) -> Array[String]:
	var valid_directions: Array[String]
	if !((level_pos - Vector2i(1,0) ) in visited_worlds) and (level_pos.x > 0):
		valid_directions.append("left")
	if !((level_pos + Vector2i(1,0) ) in visited_worlds) and (level_pos.x < 5): # TODO dont hard-code world max
		valid_directions.append("right")
	if !((level_pos - Vector2i(0,1) ) in visited_worlds) and (level_pos.y > 0):
		valid_directions.append("up")
	if !((level_pos + Vector2i(0,1) ) in visited_worlds) and (level_pos.y < 2): # TODO dont hard-code world max
		valid_directions.append("down")
	return valid_directions

# get a string for the file of the next level based on the built world
func get_next_level(level_pos: Vector2i, direction: String) -> String:
	visited_worlds.append(level_pos)
	var next_level: String
	if direction in get_valid_directions(level_pos):
		if direction == "left":
			next_level = world_map[level_pos.x - 1][level_pos.y]
		elif direction == "right":
			next_level = world_map[level_pos.x + 1][level_pos.y]
		elif direction == "up":
			next_level = world_map[level_pos.x][level_pos.y - 1]
		elif direction == "down":
			next_level = world_map[level_pos.x][level_pos.y + 1]
	else:
		next_level = "ERROR INVALID LEVEL"
	return next_level

# set up the world which is being used
# TODO actually set this up instead of hard-coding
func set_world() -> void:
	world_map = []
	var level_A: String = "res://levels/level_a.tscn"
	var level_B: String = "res://levels/level_b.tscn"
	var level_C: String = "res://levels/level_c.tscn"
	var column = [level_A, level_B, level_C]
	world_map.append(column)
	world_map.append(column)
	world_map.append(column)
	world_map.append(column)
	world_map.append(column)
