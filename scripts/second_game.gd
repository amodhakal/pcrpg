extends Node2D

@onready var HealthLabel = $HealthLabel
@onready var Pirate = preload("res://components/Pirate.tscn")
@onready var crosshair_texture = preload("res://images/crosshair.png")
var crosshair_sprite: Sprite2D

const VIEWPORT_WIDTH = 1152
const VIEWPORT_HEIGHT = 590
const X_BOUNDARY = 150
const Y_BOUNDARY = 150

var piratesRemaining = 38
var playerHealth = 5
var isPirateVisible = false
var currentPirate: Area2D

const swordPaths = ["res://images/bandanapiratesword.png", "res://images/darkpiratesword.png", "res://images/lightpiratesword.png"]
const gunPaths = ["res://images/darkpirategun.png", "res://images/lightpirategun.png", "res://images/lightpirateguntwo.png"]

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

	crosshair_sprite = Sprite2D.new()
	crosshair_sprite.texture = crosshair_texture
	add_child(crosshair_sprite)
	displayPlayerHealth()

func _process(delta):
	crosshair_sprite.position = get_viewport().get_mouse_position()
	
	if (!isPirateVisible):
		var chosenWidth = randi() % (VIEWPORT_WIDTH - X_BOUNDARY) + X_BOUNDARY
		var chosenHeight = randi() % (VIEWPORT_HEIGHT - Y_BOUNDARY) + Y_BOUNDARY
		
		var swordChosen = [true, false].pick_random()
		var chosenTexture = load((swordPaths if swordChosen else gunPaths).pick_random())
		var chosenHeartsDamaged = 1 if swordChosen else 2
		var timeForDamage = 1 if swordChosen else 2
		
		currentPirate = Pirate.instantiate()
		currentPirate.texture = chosenTexture
		currentPirate.heartsDamaged = chosenHeartsDamaged
		currentPirate.timeForDamage = timeForDamage
		
		currentPirate.position = Vector2(chosenWidth, chosenHeight)
		currentPirate.PirateClicked.connect(onPirateClicked)
		currentPirate.DamageTaken.connect(onPirateDamageTaken)
		add_child(currentPirate)
		
		piratesRemaining -= 1
		isPirateVisible = true

func onPirateDamageTaken(heartsDamaged):
	playerHealth -= heartsDamaged
	currentPirate.queue_free()
	isPirateVisible = false
	
	print("Damage taken")
	
	if (playerHealth < 0):
		print("Game lost")
		# TODO: Handle player loss
	
	displayPlayerHealth()
		
func onPirateClicked():
	await get_tree().create_timer(0.75).timeout 
	currentPirate.queue_free()
	isPirateVisible = false
	piratesRemaining -= 1
	
	print("Clicked on time")
	
	if ( piratesRemaining < 0):
		print("Game win")
		# TODO: Handle game win


func displayPlayerHealth():
	HealthLabel.text = ""
	for i in playerHealth:
		HealthLabel.text += " ❤️"
