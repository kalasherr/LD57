extends TowerBlock
class_name MineBlock

func _ready():
	init_variables()

func init_variables():
	resources = {
	"wheat" : 20
	}
	needed_workers = 3

func work():
	init_variables()
	print(global_position.y)
	if global_position.y >= 0 or abs(global_position.y) < 0.1:
		workers = request_workers()
		var sum = 0
		for worker in workers:
			if find_block_near("forge"):
				game.resources["ingots"] += 2 * worker
				sum += 2 * worker
			else:
				game.resources["ore"] += 3 * worker
				sum += 3 * worker
		$Label.rotation = G.game.get_node("Blocks").rotation
		$Label.text = "+" + str(sum)
		$Label.visible = true
		await get_tree().create_timer(0.5).timeout
		$Label.visible = false
