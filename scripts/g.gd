extends Node

@onready var game = get_parent().get_node("GameScene/GameObjects")
@onready var hud = game.get_parent().get_node("Camera/CanvasLayer/HUD")
func _ready():
	Transfer.get_node("ColorRect").modulate.a = 0

func update_variables():
	game = get_parent().get_node("GameScene/GameObjects")
	hud = game.get_parent().get_node("Camera/CanvasLayer/HUD")
	

func game_over():
	restart()
	

func restart():
	get_tree().paused = true
	while Transfer.get_node("ColorRect").modulate.a <= 1.0:
		Transfer.get_node("ColorRect").modulate.a += 1.0 * get_process_delta_time()
		await get_tree().process_frame
	get_parent().get_node("GameScene").queue_free()
	get_tree().paused = false
	await get_tree().create_timer(2).timeout
	get_parent().add_child(load("res://scenes/game_scene.tscn").instantiate())
	update_variables()
	while Transfer.get_node("ColorRect").modulate.a >= 0.0:
		Transfer.get_node("ColorRect").modulate.a -= 1.0 * get_process_delta_time()
		await get_tree().process_frame
	
func finish_game():
	Transfer.finish()
