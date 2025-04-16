extends Node

const initialRackPosition = Vector2(730, 400)
const initialAlexPosition = Vector2(450, 400)
const showdownMovement = 100

@onready var RackSprite = $RackSprite
@onready var RackHealthLabel = $RackHealth
@onready var AlexSprite = $AlexSprite
@onready var AlexHealthLabel = $AlexHealth
@onready var WaitLabel = $WaitLabel
@onready var BloodTexture = preload("res://images/bloodpirate.png")
@onready var AlexTexture = preload("res://images/darkpirategun.png")
@onready var RackTexture = preload("res://images/lightpirategun.png")

@onready var WinPath = "res://scenes/Win.tscn"
@onready var LossPath = "res://scenes/ThirdLoss.tscn"

var state = "InitialState"
var shotFired = false
var rackHealth = 10
var alexHealth = 10
var processing_shot = false 
	
func _ready() -> void:
	reset_positions()
	update_health_display()

func _process(delta: float) -> void:	
	if Input.is_action_just_pressed("Shoot"):
		handle_player_input()
		
	if state == "InitialState" and not processing_shot:
		start_new_round()
		
	elif state == "ReadyState" and not processing_shot:
		move_characters(delta)

func handle_player_input() -> void:
	if processing_shot:
		return
		
	if state != "ShootState":
		processing_shot = true
		print("Shot too early!")
		rackHealth -= 1
		update_health_display()
		handleGameOver()
		return
	elif shotFired:
		print("Too late, shot already fired")
		return

	processing_shot = true
	print("Player shot first!")
	shotFired = true
	alexHealth -= 1
	update_health_display()
	RackSprite.texture = BloodTexture 
	if get_tree():
		await get_tree().create_timer(1.0).timeout 
		handleGameOver()

func start_new_round() -> void:
	WaitLabel.visible = false
	shotFired = false
	reset_positions()
	reset_textures()
	state = "ReadyState"

func reset_positions() -> void:
	RackSprite.position = initialRackPosition
	AlexSprite.position = initialAlexPosition

func reset_textures() -> void:
	RackSprite.texture = RackTexture
	AlexSprite.texture = AlexTexture
	if RackSprite.scale.x < 0:
		RackSprite.scale.x *= -1
	if AlexSprite.scale.x < 0:
		AlexSprite.scale.x *= -1

func move_characters(delta: float) -> void:
	RackSprite.position.x += showdownMovement * delta
	AlexSprite.position.x -= showdownMovement * delta
	
	if AlexSprite.position.x <= 200:
		state = "PrepareState"
		WaitLabel.visible = true
		RackSprite.scale.x *= -1
		AlexSprite.scale.x *= -1
		call_deferred("schedule_shooting_preparation")

func schedule_shooting_preparation() -> void:
	var timer = get_tree().create_timer(randf_range(1.0, 2.0))
	await timer.timeout
	prepare_shooting()

func prepare_shooting() -> void:
	if state != "PrepareState":
		return
		
	WaitLabel.visible = false
	state = "ShootState"
	
	# Safe call to enemy shooting
	call_deferred("schedule_enemy_shooting")

func schedule_enemy_shooting() -> void:
	var timer = get_tree().create_timer(randf_range(0, 0.3) + 0.25)
	await timer.timeout
	handle_enemy_shooting()

func handle_enemy_shooting() -> void:
	if state != "ShootState" or shotFired or processing_shot:
		return
		
	processing_shot = true
	print("Enemy shot first!")
	shotFired = true
	rackHealth -= 1
	update_health_display()
	AlexSprite.texture = BloodTexture 
	await get_tree().create_timer(1.0).timeout 
	handleGameOver()
	
func handleGameOver():
	print(rackHealth)
	if rackHealth <= 0:
		print("Game lost") 
		AlexSprite.texture = BloodTexture
		await get_tree().create_timer(1.0).timeout 
		get_tree().change_scene_to_file(LossPath)
		return
	if alexHealth <= 0:
		print("Game won")
		RackSprite.texture = BloodTexture
		await get_tree().create_timer(1.0).timeout 
		get_tree().change_scene_to_file(WinPath)
		return
	
	state = "InitialState"
	processing_shot = false

func update_health_display() -> void:	
	RackHealthLabel.text = ""
	for i in rackHealth:
		RackHealthLabel.text += "❤️ "
		
	AlexHealthLabel.text = ""
	for i in alexHealth:
		AlexHealthLabel.text += "❤️ "
