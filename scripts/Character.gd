extends CharacterBody2D

const JUMP = -350
var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")
var isGameOver = false

func _physics_process(delta):
	if (isGameOver):
		velocity.x = 0
		velocity.y += GRAVITY * delta
		move_and_slide()
		return

	velocity.y += GRAVITY * delta

	if Input.is_action_just_pressed("ProtagonistUp"):
		velocity.y = JUMP

	velocity.x = delta * 10_000
	move_and_slide()
	
func emitGameOver():
	if ( isGameOver):
		return
		
	isGameOver = true
