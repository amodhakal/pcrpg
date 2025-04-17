extends Node2D

var FIRST_GAME = "res://scenes/FirstGame.tscn"

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	AudioManager.playMusic("first")

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file(FIRST_GAME)
