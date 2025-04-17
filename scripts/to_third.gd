extends Node2D

var THIRD_GAME = "res://scenes/ThirdGame.tscn"

func _ready():
	AudioManager.playMusic("win")

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file(THIRD_GAME)
