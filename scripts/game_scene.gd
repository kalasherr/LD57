extends Node2D

@onready var camera = get_parent().get_node("Camera")
var offset = Vector2(0, 16)
var level = 1
var max_x = 128
var interaction_locked = false
var flips = 0
var resources = {
	"wheat": 13,
	"ore": 0,
	"ingots": 0,
	"coins": 0
}

var workers = []

func _ready():
	await get_tree().create_timer(2).timeout
	while abs(camera.position.y) > 100:
		camera.position -= camera.position / 8 * 60 * get_process_delta_time()
		await get_tree().process_frame
	get_node("../Camera/CanvasLayer/HUD").init()
	update_hud(resources)

func _process(delta):
	
	if !interaction_locked:
		if Input.is_action_just_pressed("interact"):
			work()
	if Input.is_action_just_pressed("wheel_down"):
		camera.position.y += 32
	if Input.is_action_just_pressed("wheel_up"):
		camera.position.y -= 32

func count_workers():
	workers = []
	for room in get_node("Blocks").get_children():
		if room is LivingBlock:
			for i in range(0,room.workers_count):
				if resources["wheat"] - 3 >= 0:
					resources["wheat"] -=  3
					workers.append(room.efficiency)
	workers.shuffle()
	return workers

func find_living_room():
	return count_workers()

func work():
	var blocks = get_node("Blocks").get_children()
	blocks.shuffle()
	for block in blocks:
		if block is LivingBlock:
			block.work()
	interaction_locked = true
	$MouseFollow.visible = false
	count_workers()
	var beaconed = false
	for block in get_node("Blocks").get_children():
		if block is BeaconBlock:
			$MouseFollow.visible = false
			
			block.work()
			
			beaconed = true
	if not beaconed:
		for block in get_node("Blocks").get_children():
			if block is FarmBlock:
				block.work()
		if resources["wheat"] < 3:
			G.game_over()
			
		await get_tree().create_timer(1).timeout
	
		for block in get_node("Blocks").get_children():
			if block is MineBlock:
				block.work()
		
		await get_tree().create_timer(1).timeout

		for block in get_node("Blocks").get_children():
			if block is MarketBlock:
				block.work()
		for block in get_node("Blocks").get_children():
			if block is AnchorBlock:
				block.play_start_sound()
				await get_tree().create_timer(0.2).timeout
				block.play_moving_sound()
				await block.work()
		var max = 0
		for block in get_node("Blocks").get_children():
			if block.global_position.y > max:
				max = block.global_position.y
		G.hud.update_depth(max)
		interaction_locked = false
		update_hud(resources)
		print(resources)
		if not beaconed:
			$MouseFollow.visible = true
		flips += 1
		G.hud.get_node("LeftPanel").update_flips()
	else:
		Transfer.finish()

func relocate_all_to_anchor():
	pass

func choose_block(block):
	var sprite = $MouseFollow/Sprite
	sprite.texture = block.get_node("Sprite").texture

func place_block(block_scene, coords):
		var block = load(block_scene).instantiate()
		block.init_variables()
		if block_scene and find_block(coords) == false and (find_block(coords + Vector2(0,32)) or find_block(coords + Vector2(0,-32)) or (coords.y == 0 and (find_block(coords + Vector2(-64, 0)) or find_block(coords + Vector2(64,0))))) and (block.request_resources() and abs(coords.x) <= max_x):
			%Click.play()
			block.scale = Vector2.ZERO
			get_node("Blocks").add_child(block)
			block.position = coords
			block.scale = Vector2(1.15,1.15)
			await get_tree().create_timer(0.08).timeout
			block.scale = Vector2(1,1)
			G.hud.update(resources)
		elif !G.hud.hover():
			%Cancel.play()
			block.queue_free()
		else:
			block.queue_free()

func find_block(coords):
	if int(round(get_node("Blocks").rotation / PI)) % 2 == 0:
		for block in get_node("Blocks").get_children():
			if block.position == coords:
				return true
	else:
		for block in get_node("Blocks").get_children():
			if block.position == coords:
				return true
	return false

func update_hud(resources):
	get_node("../Camera/CanvasLayer/HUD").update(resources)
