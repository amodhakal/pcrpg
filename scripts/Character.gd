extends CharacterBody2D

const JUMP = -350
const VIEWPORT_WIDTH = 1152
const LOG_DISTANCE_X = VIEWPORT_WIDTH / 4
const INITIAL_LOG_X = LOG_DISTANCE_X * 2 + 50

@onready var logsLabel = $"../Camera2D/Label"
	
var logsPassed = 0
var previousX = 0
var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")
var isGameOver = false

func _process(delta):
	var currentX = self.position.x
	
	if logsPassed == 0:
		if currentX > INITIAL_LOG_X:
			if logsPassed < 48:
				logsPassed += 1
				
			logsLabel.text = str(logsPassed) + "/48 logs passed"
			previousX = currentX
		
	else:
		if currentX > previousX + LOG_DISTANCE_X:
			if logsPassed < 48:
				logsPassed += 1
				
			logsLabel.text = str(logsPassed) + "/48 logs passed"
			previousX = currentX			
	


func _physics_process(delta):
	if (isGameOver):
		velocity.x = 0
		velocity.y += GRAVITY * delta
		move_and_slide()
		return

	velocity.y += GRAVITY * delta

	if Input.is_action_just_pressed("ProtagonistUp"):
		velocity.y = JUMP
		AudioManager.playEffect("jump")

	velocity.x = delta * 10_000
	move_and_slide()
	
func emitGameOver():
	if ( isGameOver):
		return
		
	isGameOver = true
