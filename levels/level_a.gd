extends "level_template.gd"

func spawn_enemies() -> void:
	if should_i_spawn_enemies() and level_started:
		var e = GrowlitheEnemy.instantiate()
		add_child(e)
		e.position = Vector2(100,100)
		enemy_array.append(e)
		last_enemy = Time.get_unix_time_from_system()

func should_i_spawn_enemies() -> bool:
	var now_time: float = Time.get_unix_time_from_system()
	return ( (now_time - last_enemy) > time_between_enemies)

func is_level_complete() -> bool:
	var is_complete := false
	var now_time: float = Time.get_unix_time_from_system()
	if now_time - start_time > 5:
		is_complete = true
	return is_complete
