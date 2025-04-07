extends TowerBlock
class_name AnchorBlock
var initial_timer = 2
var rotation_timer = initial_timer

func work():
	var init_rotation = get_parent().rotation
	get_parent().rotation -= PI/100
	await get_tree().create_timer(0.08).timeout
	get_parent().rotation += PI/100
	while rotation_timer >= 0:
		if get_parent().rotation +  PI/initial_timer * get_process_delta_time() < init_rotation + PI:
			get_parent().rotation +=  PI/initial_timer * get_process_delta_time()
		rotation_timer -= get_process_delta_time()
		await get_tree().process_frame
	rotation_timer = initial_timer
	get_parent().rotation = init_rotation + PI

func play_start_sound():
	$StartSound.play(0.0)

func play_moving_sound():
	$MovingSound.play(0.0)
