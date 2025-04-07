extends Control

func init():
	var speed = -10
	while $Shop.position != Vector2(1488,0) or $Shop.position.x < 1488:
		if abs($Shop.position.x - 1488) > abs(speed):
			$Shop.position.x += speed * get_process_delta_time() * 60
			speed = min(-abs($Shop.position.x - 1488)/10, -2)
			await get_tree().process_frame
		else:
			$Shop.position.x = 1488
	speed = 10
	while $LeftPanel.position != Vector2(0,0) or $LeftPanel.position.x > 0:
		if abs($LeftPanel.position.x) > speed:
			$LeftPanel.position.x += speed * get_process_delta_time() * 60
			speed = max(-$LeftPanel.position.x/10, 2)
			await get_tree().process_frame
		else:
			$LeftPanel.position.x = 0

func update(resources):
	$Shop/Resources/Label.text = str(resources["ore"])
	$Shop/Resources/Label2.text = str(resources["ingots"])
	$Shop/Resources/Label3.text = str(resources["wheat"])
	$Shop/Resources/Label4.text = str(resources["coins"])
	var living = 0
	for block in G.game.get_node("Blocks").get_children():
		if block is LivingBlock:
			living += 2
	$Shop/Resources/Label5.text = str(living)
	
	# it was my best idea
	$Shop/NeededResources/Label.text = str(15)
	$Shop/NeededResources/Label2.text = str(7)
	$Shop/NeededResources/Label3.text = str(20)
	$Shop/NeededResources/Label4.text = str(8)
	$Shop/NeededResources/Label5.text = str(10)
	$Shop/NeededResources/Label6.text = str(20)
	$Shop/NeededResources/Label7.text = str(5)
	$Shop/NeededResources/Label8.text = str(10)
	$Shop/NeededResources/Label9.text = str(20)
	$Shop/NeededResources/Label10.text = str(5)
	$Shop/NeededResources/Label11.text = str(5)
	$Shop/NeededResources/Label12.text = str(10)
	$Shop/NeededResources/Label13.text = str(5)
	$Shop/NeededResources/Label14.text = str(50)
	$Shop/NeededResources/Label15.text = str(30)
	

func _on_texture_button_pressed():
	G.game.get_node("MouseFollow").pick("res://scenes/blocks/farm_block.tscn")


func _on_texture_button_3_pressed():
	G.game.get_node("MouseFollow").pick("res://scenes/blocks/mine_block.tscn")


func _on_texture_button_2_pressed():
	G.game.get_node("MouseFollow").pick("res://scenes/blocks/living_room_block.tscn")


func _on_texture_button_5_pressed():
	G.game.get_node("MouseFollow").pick("res://scenes/blocks/market_block.tscn")


func _on_texture_button_4_pressed():
	G.game.get_node("MouseFollow").pick("res://scenes/blocks/gym_block.tscn")


func _on_texture_button_6_pressed():
	G.game.get_node("MouseFollow").pick("res://scenes/blocks/forge_block.tscn")


func _on_texture_button_7_pressed():
	G.game.get_node("MouseFollow").pick("res://scenes/blocks/connector_block.tscn")

func _on_texture_button_8_pressed():
	G.game.get_node("MouseFollow").pick("res://scenes/blocks/water_block.tscn")

func _on_texture_button_9_pressed():
	G.game.get_node("MouseFollow").pick("res://scenes/blocks/beacon_block.tscn")

func update_depth(max):
	max = round(max/32)
	if max > 2:
		unlock([0])
	if max > 4:
		unlock([0,1])
	if max > 6:
		unlock([0,1,2])
	if max > 9:
		unlock([0,1,2,3])
	if max > 12:
		unlock([0,1,2,3,4,5,6])

func unlock(array):
	for lock in array:
		await get_node("Shop/Locks").get_child(lock).unlock()
		
func hover():
	var checked = false
	for a in $Shop/Buttons.get_children():
		if a.is_hovered():
			checked = true
	if $Shop/Button.is_hovered():
		checked = true
	return checked


func _on_button_pressed():
	if !G.game.interaction_locked:
		G.game.get_node("Click").play(0.0)
		G.game.work()

func uninit():
	var time = 5
	var speed = 3
	while time > 0:
		time -= get_process_delta_time()
		$Shop.position.x += speed * get_process_delta_time() * 60
		$LeftPanel.position.x -= speed * get_process_delta_time() * 60
		await get_tree().process_frame
