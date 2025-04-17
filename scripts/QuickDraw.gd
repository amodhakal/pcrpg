extends Node

@onready var RackHealthLabel    = $RackHealth
@onready var AlexSprite         = $AlexSprite
@onready var BloodSprite		= $BloodSprite
@onready var AlexHealthLabel    = $AlexHealth
@onready var WaitLabel          = $WaitLabel
@onready var BloodTexture       = preload("res://images/bloodpirate.png")
@onready var redOverlay         = $redOverlay
@onready var firstPerson        = $FirstPerson
@onready var JonesFlash 		= $AlexSprite/AlexDamaged

@onready var WinPath            = "res://scenes/Win.tscn"
@onready var LossPath           = "res://scenes/ThirdLoss.tscn"

var state            = "InitialState"
var shotFired        = false
var rackHealth       = 2
var alexHealth       = 5
var processing_shot  = false

func _ready() -> void:
	JonesFlash.modulate = Color(1, 0, 0, 0)
	BloodSprite.visible = false
	firstPerson.visible = false
	update_health_display()
	redOverlay.mouse_filter = Control.MOUSE_FILTER_IGNORE
	redOverlay.color = Color(1, 0, 0, 0)
	redOverlay.z_index = 100
	add_child(redOverlay)
	# Kick off the first round
	start_new_round()

func _process(delta: float) -> void:
	WaitLabel.visible = (state != "ShootState")
	if Input.is_action_just_pressed("Shoot"):
		handle_player_input()
	BloodSprite.visible = (alexHealth <= 0)

func handle_player_input() -> void:
	showGun()
	if processing_shot:
		return

	if state != "ShootState":
		processing_shot = true
		print("Shot too early!")
		showDamageEffect()
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
	flash_jones()
	alexHealth -= 1
	update_health_display()
	await get_tree().create_timer(1.0).timeout
	handleGameOver()

func start_new_round() -> void:
	state = "InitialState"
	shotFired = false
	processing_shot = false
	schedule_shooting_preparation()

func schedule_shooting_preparation() -> void:
	await get_tree().create_timer(randf_range(3.0, 6.0)).timeout
	state = "ShootState"
	schedule_enemy_shooting()

func schedule_enemy_shooting() -> void:
	var timer = get_tree().create_timer(randf_range(0.0, 0.3) + 0.3)
	await timer.timeout
	handle_enemy_shooting()

func handle_enemy_shooting() -> void:
	if state != "ShootState" or shotFired or processing_shot:
		return
	processing_shot = true
	state = "InitialState"
	print("Enemy shot first!")
	shotFired = true
	showDamageEffect()
	rackHealth -= 1
	update_health_display()
	await get_tree().create_timer(1.0).timeout
	handleGameOver()

func handleGameOver() -> void:
	print(rackHealth)
	print(alexHealth)
	
	if rackHealth <= 0:
		await get_tree().create_timer(1.0).timeout
		get_tree().change_scene_to_file(LossPath)
		return
	if alexHealth <= 0:
		await get_tree().create_timer(1.0).timeout
		get_tree().change_scene_to_file(WinPath)
		return
	# Not over—start the next round
	start_new_round()

func update_health_display() -> void:
	RackHealthLabel.text = ""
	for i in range(rackHealth):
		RackHealthLabel.text += "❤️ "
	AlexHealthLabel.text = ""
	for i in range(alexHealth):
		AlexHealthLabel.text += "❤️ "

func showDamageEffect() -> void:
	redOverlay.color = Color(1, 0, 0, 0.5)
	await get_tree().create_timer(0.2).timeout
	redOverlay.color = Color(1, 0, 0, 0)
	
func flash_jones():
	JonesFlash.modulate = Color(1, 0, 0, 0.6)
	await get_tree().create_timer(0.2).timeout
	JonesFlash.modulate = Color(1, 0, 0, 0)

func showGun() -> void:
	if not firstPerson.visible:
		firstPerson.visible = true
		await get_tree().create_timer(1.0).timeout
		firstPerson.visible = false
