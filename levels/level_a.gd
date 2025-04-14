extends "level_template.gd"

var spawn_locations = [Vector2(100,100), Vector2(700,100), Vector2(700,700), Vector2(100,700)]

func specific_level_start() -> void:
	time_between_enemies = 0.2
	kill_target = 50

func specific_level_process(_delta: float) -> void:
	$Score.text = str(kill_count) + "/" + str(kill_target)

func spawn_enemies() -> void:
	if should_i_spawn_enemies() and level_started:
		var e = GrowlitheEnemy.instantiate()
		add_child(e)
		e.position = spawn_locations[randi_range(0,3)]
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
