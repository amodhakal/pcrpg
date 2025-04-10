extends Node2D

var FIRST_GAME = "res://scenes/FirstGame.tscn"

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file(FIRST_GAME)
