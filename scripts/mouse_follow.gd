extends Node2D
var chosen_block = null
func _process(delta):
	if chosen_block:
		self.rotation = G.game.get_node("Blocks").rotation 
		var block = load(chosen_block).instantiate()
		get_node("Sprite").texture = block.get_node("Sprite").texture
		G.hud.get_node("LeftPanel").get_info(block)
		if Input.is_action_just_pressed("lmb"):
			if int(round(G.game.get_node("Blocks").rotation / PI)) % 2 == 0:
				G.game.place_block(chosen_block, Vector2(round(get_global_mouse_position().x / 64) * 64, round(get_global_mouse_position().y / 32)  * 32))
			else:
				G.game.place_block(chosen_block, -Vector2(round(get_global_mouse_position().x / 64) * 64, round(get_global_mouse_position().y / 32)  * 32))
	else:
		get_node("Sprite").texture = null
	global_position = Vector2(round(get_global_mouse_position().x / 64) * 64, round(get_global_mouse_position().y / 32)  * 32)
	

func pick(object):
	%Click.play()
	chosen_block = object

func unpick():
	chosen_block = null
