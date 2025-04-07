extends TowerBlock
class_name BeaconBlock
var time = 0
var left = false
func work():
	G.finish_game()

func init_variables():
	resources = {
	"coins": 50,
	"ingots": 30
	}

func _process(delta):
	if left:
		get_node("Light/PointLight2D").energy += get_process_delta_time() / 3
		await get_tree().process_frame
		if get_node("Light/PointLight2D").energy > 1.2:
			left = false
	else:
		get_node("Light/PointLight2D").energy -= get_process_delta_time() / 3
		await get_tree().process_frame
		if get_node("Light/PointLight2D").energy < 0.8:
			left = true
	#time += get_process_delta_time()
	#get_node("Light").scale.x = max(abs(sin(time)) * 2, 0.4) * sign(sin(time))
	#get_node("Light").scale.y = max(abs(cos(time)) * 2, 0.4) * sign(cos(time))
	#await get_tree().process_frame
