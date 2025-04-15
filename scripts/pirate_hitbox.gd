extends Area2D

signal PirateClicked
signal DamageTaken

var bloodTexture = preload("res://images/bloodpirate.png")
var isClicked = false

@onready var pirate = $Darkpiratesword
@onready var collision = $CollisionPolygon2D
@onready var timer = $Timer

@export var texture: Texture2D
@export var heartsDamaged: int
@export var timeForDamage: float

func _ready() -> void:
	pirate.texture = texture
	input_pickable = true

	timer.wait_time = timeForDamage
	timer.start()
	
func _on_timer_timeout() -> void:
	if not isClicked:
		emit_signal("DamageTaken", heartsDamaged)

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			pirate.texture = bloodTexture
			collision.disabled = true
			isClicked = true
			timer.stop()
			emit_signal("PirateClicked")
