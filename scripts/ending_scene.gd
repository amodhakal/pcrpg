extends Node2D

@onready var Scrolled = $Scrolled


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	AudioManager.playMusic("victory")

func _process(delta: float) -> void:
	Scrolled.position.y -= delta * 25
	
