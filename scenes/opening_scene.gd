extends Node2D

@onready var Scrolled = $Scrolled

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	Scrolled.position.y -= delta * 15
	pass
