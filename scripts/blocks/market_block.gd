extends TowerBlock
class_name MarketBlock

func _ready():
	init_variables()

func init_variables():
	resources = {
		"wheat":20,
		"ore":5
	}
	needed_workers = 1

func work():
	init_variables()
	var workers = request_workers()
	for worker in workers:
		var living_rooms = 0
		for room in game.get_node("Blocks").get_children():
			if room is LivingBlock:
				living_rooms += 1
		if game.resources["ingots"] > 30:
			game.resources["coins"] += min(10,game.resources["ingots"] - 30) * 3
			game.resources["ingots"] -= min(10,game.resources["ingots"] - 30)
		elif game.resources["ore"] > 20:
			game.resources["coins"] += min(10, game.resources["ore"] - 20)
			game.resources["ore"] -= min(10, game.resources["ore"] - 20)
		elif game.resources["wheat"] > max(living_rooms * 6,20):
			game.resources["coins"] += int(min(10, game.resources["wheat"] - living_rooms * 6) / 2)
			game.resources["wheat"] -= min(10, game.resources["wheat"] - living_rooms * 6)
