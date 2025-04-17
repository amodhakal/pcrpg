extends Area2D

signal PirateClicked
signal DamageTaken

var isClicked = false

@onready var pirate = $Darkpiratesword
@onready var collision = $CollisionShape2D
@onready var timer = $Timer
@onready var bloodTexture = preload("res://images/bloodpirate.png")

@export var texture: Texture2D
@export var heartsDamaged: int
@export var timeForDamage: float

func _ready() -> void:
	pirate.texture = texture
	collision.shape.size = texture.get_size()
	input_pickable = true

	timer.wait_time = timeForDamage
	timer.start()
	
func _on_timer_timeout() -> void:
	if not isClicked:
		emit_signal("DamageTaken", heartsDamaged)

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			collision.disabled = true
			isClicked = true
			timer.stop()
			pirate.texture = bloodTexture
			emit_signal("PirateClicked")
