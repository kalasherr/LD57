extends Node2D

class_name TowerBlock

@onready var game = get_parent().get_parent()

var active = true
var efficiency = 1
var type
var needed_workers
var workers = []
var resources = {
	"wheat" : 5
}
func _ready():
	pass

func init_variables():
	pass

func request_workers():
	var workers = game.workers
	var to_return = []
	if needed_workers:
		for i in range(0, needed_workers):
			if len(workers) > 0:
				to_return.append(workers[0])
				workers.pop_front()
			else:
				break
	return to_return

func work():
	pass

func find_block_near(condition):
	var vectors = [Vector2(64,0),Vector2(-64,0),Vector2(0,32),Vector2(0,-32)]
	for block in game.get_node("Blocks").get_children():
		for vector in vectors:
			if block.position == position + vector and block.check_condition(condition) and not (block is ConnectorBlock and self is ConnectorBlock):
				return true

func check_condition(condition):
	pass

func request_resources():
	for resource in resources:
		if G.game.resources[resource] >= resources[resource]:
			continue
		else:
			return false
	for resource in resources:
		G.game.resources[resource] -= resources[resource]
	return true
