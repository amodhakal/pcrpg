extends Node2D

var SECOND_GAME = "res://scenes/SecondGame.tscn"

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	AudioManager.playMusic("win")

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file(SECOND_GAME)
