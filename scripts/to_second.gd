extends Node2D

var SECOND_GAME = "res://scenes/SecondGame.tscn"

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file(SECOND_GAME)
