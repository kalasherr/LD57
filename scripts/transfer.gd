extends CanvasLayer
var finished = false

func finish():
	G.hud.uninit()
	await get_tree().create_timer(2).timeout
	while G.game.camera.position.y > -1500:
		if (-1300 - G.game.camera.position.y) < 3:
			G.game.camera.position.y = -1500
			break
		G.game.camera.position += Vector2(0, min((-1300 - G.game.camera.position.y) / 12 * get_process_delta_time(),-3))
		await get_tree().process_frame
	await get_tree().create_timer(1).timeout
	$Label/Label.text = "You made it in " + str(G.game.flips) + " flips. Congrats!"
	while $Label.modulate.a <= 1:
		$Label.modulate.a += get_process_delta_time()
		await get_tree().process_frame
