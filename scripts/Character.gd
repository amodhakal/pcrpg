extends CharacterBody2D

const JUMP = -350
var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	velocity.y += GRAVITY * delta
	
	if Input.is_action_just_pressed("ProtagonistUp"):
		velocity.y = JUMP
		
	# TODO: For now
	velocity.x = delta * 10_000

	move_and_slide()
