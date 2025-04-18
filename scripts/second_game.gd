extends Node2D

@onready var HealthLabel = $HealthLabel
@onready var Pirate = preload("res://components/Pirate.tscn")
@onready var crosshair_texture = preload("res://images/crosshair.png")
@onready var EnemiesRemainingLabel = $EnemiesRemainingLabel # Enemies remaining display
@onready var redOverlay       = $redOverlay # Variable for the damage flash node.

@onready var TO_THIRD_PATH = "res://scenes/ToThird.tscn"
@onready var LOSS_PATH = "res://scenes/SecondLoss.tscn"

var crosshair_sprite: Sprite2D

const VIEWPORT_WIDTH = 1152
const VIEWPORT_HEIGHT = 590
const X_BOUNDARY = 150
const Y_BOUNDARY = 350

var piratesRemaining = 60
var playerHealth = 5
var isPirateVisible = false
var currentPirate: Area2D
var isReady = false

const swordPaths = ["res://images/bandanapiratesword.png", "res://images/darkpiratesword.png", "res://images/lightpiratesword.png"]
const gunPaths = ["res://images/darkpirategun.png", "res://images/lightpirategun.png", "res://images/lightpirateguntwo.png"]



func _ready():
	AudioManager.playMusic("second")
	displayPlayerHealth()
	displayEnemiesRemaining()
	
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	await get_tree().create_timer(2).timeout 
	isReady = true

	crosshair_sprite = Sprite2D.new()
	crosshair_sprite.texture = crosshair_texture
	crosshair_sprite.z_index = 10
	add_child(crosshair_sprite)
	
	redOverlay.mouse_filter = Control.MOUSE_FILTER_IGNORE
	redOverlay.color = Color(1, 0, 0, 0)                            
	redOverlay.z_index = 100                                 
	add_child(redOverlay)                                   


func _process(delta):
	if !isReady:
		return
		
	crosshair_sprite.position = get_viewport().get_mouse_position()
	
	if (!isPirateVisible):
		var chosenWidth = randi() % (VIEWPORT_WIDTH - X_BOUNDARY * 2) + X_BOUNDARY
		var chosenHeight = randi() % (VIEWPORT_HEIGHT - Y_BOUNDARY) + Y_BOUNDARY
		
		var swordChosen = [true, false].pick_random()
		var chosenTexture = load((swordPaths if swordChosen else gunPaths).pick_random())
		var chosenHeartsDamaged = 1 if swordChosen else 2
		var timeForDamage = 0.47 if swordChosen else 0.52
		
		currentPirate = Pirate.instantiate()
		currentPirate.texture = chosenTexture
		currentPirate.heartsDamaged = chosenHeartsDamaged
		currentPirate.timeForDamage = timeForDamage
		currentPirate.pirateType = "sword" if swordChosen else "shot"
		
		currentPirate.position = Vector2(chosenWidth, chosenHeight)
		currentPirate.PirateClicked.connect(onPirateClicked)
		currentPirate.DamageTaken.connect(onPirateDamageTaken)
		
		add_child(currentPirate)
		
		displayEnemiesRemaining()  
		isPirateVisible = true

func onPirateDamageTaken(heartsDamaged):
	playerHealth -= heartsDamaged
	displayPlayerHealth()
	showDamageEffect()  
	
	if (playerHealth <= 0):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().change_scene_to_file(LOSS_PATH)
	
	displayPlayerHealth()
		
func onPirateClicked():
	AudioManager.playEffect("shot")
	piratesRemaining -= 1
	displayEnemiesRemaining()
	await get_tree().create_timer(0.75).timeout 
	currentPirate.queue_free()
	isPirateVisible = false

	
	if ( piratesRemaining <= 0):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().change_scene_to_file(TO_THIRD_PATH)


func displayPlayerHealth():
	HealthLabel.text = ""
	for i in playerHealth:
		HealthLabel.text += " ❤️"

func showDamageEffect() -> void:

	redOverlay.color = Color(1, 0, 0, 0.5)                  # Set overlay to semi-transparent red.
	await get_tree().create_timer(0.2).timeout            # Wait 0.2 seconds.
	redOverlay.color = Color(1, 0, 0, 0)                    # Fade back to transparent.
	
func displayEnemiesRemaining():
	EnemiesRemainingLabel.text = "Jones' crew remaining: " + str(piratesRemaining)
