extends TowerBlock
class_name FarmBlock


func _ready():
	init_variables()

func init_variables():
	resources = {
	"wheat" : 15
	}
	type = "farm"
	needed_workers = 2

func work():
	init_variables()
	print(global_position.y)
	if global_position.y <= 0 or abs(global_position.y) < 0.1:
		workers = request_workers()
		var sum = 0
		for worker in workers:
			if find_block_near("water"):
				game.resources["wheat"] += 15 * worker
				sum += 15 * worker
			else:
				game.resources["wheat"] += 10 * worker
				sum += 10 * worker
		$Label.rotation = G.game.get_node("Blocks").rotation
		$Label.text = "+" + str(sum)
		$Label.visible = true
		await get_tree().create_timer(0.5).timeout
		$Label.visible = false
func request_resources():
	if G.game.resources["wheat"] > 15:
		G.game.resources["wheat"] -= 15
		return true
	return false
