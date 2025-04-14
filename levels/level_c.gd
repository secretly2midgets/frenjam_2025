extends "level_template.gd"

func specific_level_start() -> void:
	time_between_enemies = 0.3
	kill_target = 25
	level_time_limit = 1000

func specific_level_process(_delta: float) -> void:
	$Score.text = str(kill_count) + "/" + str(kill_target)

func spawn_enemies() -> void:
	if should_i_spawn_enemies() and level_started:
		var e = UndertaleEnemy.instantiate()
		add_child(e)
		var valid_position = false
		var new_pos = Vector2.ZERO
		while not valid_position:
			new_pos = Vector2(randf_range(50, 750), randf_range(50, 750) )
			if new_pos.distance_to(get_node("player").position) >= 200:
				valid_position = true
		e.position = new_pos
		enemy_array.append(e)
		last_enemy = Time.get_unix_time_from_system()

func should_i_spawn_enemies() -> bool:
	var now_time: float = Time.get_unix_time_from_system()
	return ( (now_time - last_enemy) > time_between_enemies)

func is_level_complete() -> bool:
	var is_complete := false
	if kill_count >= kill_target:
		is_complete = true
	return is_complete
