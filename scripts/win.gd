extends Node2D

var endingScene = "res://scenes/EndingScene.tscn"
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	AudioManager.playMusic("victory")
	await get_tree().create_timer(5.0).timeout
	get_tree().change_scene_to_file(endingScene)
