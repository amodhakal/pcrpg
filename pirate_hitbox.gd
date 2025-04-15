extends Area2D

signal PirateClicked

var bloodTexture = preload("res://images/bloodpirate.png")
@onready var pirate = $Darkpiratesword
@onready var collision = $CollisionPolygon2D

func _ready():
	input_pickable = true

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			pirate.texture = bloodTexture
			collision.disabled = true
			emit_signal("PirateClicked")
