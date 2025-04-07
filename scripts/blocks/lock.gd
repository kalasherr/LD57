extends TextureRect
var locked = true
func unlock():
	if locked:
		$Audio.play(0.0)
		var direction = [-1,1].pick_random()
		scale = Vector2(1.1,1.1)
		var yspeed = -5
		var xspeed = randf_range(-3,3) * direction
		while global_position.y < 3000:
			var delta = get_process_delta_time()
			position += Vector2(xspeed * 60 * delta, yspeed * 60 * delta)
			yspeed += 0.5 * 60 * delta
			await get_tree().process_frame
		locked = false
		
	
