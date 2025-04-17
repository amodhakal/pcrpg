extends Node2D

@onready var ThirdPath = "res://scenes/ThirdGame.tscn"

func _ready():
	AudioManager.playMusic("loss")

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file(ThirdPath)
