extends "level_template.gd"

func spawn_enemies() -> void:
	if should_i_spawn_enemies() and level_started:
		var e = MegamanEnemy.instantiate()
		add_child(e)
		e.position = Vector2(100,100)
		enemy_array.append(e)
		last_enemy = Time.get_unix_time_from_system()

func specific_level_start() -> void:
	level_time_limit = 30

func specific_level_process(_delta: float) -> void:
	if scrolling_direction == Vector2.ZERO:
		$Score.text = str(int(Time.get_unix_time_from_system() - start_time)) + "/" + str(int(level_time_limit))

func should_i_spawn_enemies() -> bool:
	var now_time: float = Time.get_unix_time_from_system()
	return ( (now_time - last_enemy) > time_between_enemies)

func is_level_complete() -> bool:
	var is_complete := false
	var now_time: float = Time.get_unix_time_from_system()
	if now_time - start_time > level_time_limit:
		is_complete = true
	return is_complete
