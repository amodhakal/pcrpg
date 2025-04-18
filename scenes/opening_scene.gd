extends Node2D

@onready var Scrolled = $Scrolled

var ToFirstPath = "res://scenes/ToFirst.tscn"

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	AudioManager.playMusic("tension")

func _process(delta: float) -> void:
	Scrolled.position.y -= delta * 30
	
	if ( Scrolled.position.y < -1100):
		get_tree().change_scene_to_file(ToFirstPath)
