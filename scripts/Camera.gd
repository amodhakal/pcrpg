extends Camera2D

const VIEWPORT_WIDTH = 1152
const VIEWPORT_HEIGHT = 590
@export var TARGET_PATH: NodePath = "../Character"
@export var yPosition: float = VIEWPORT_HEIGHT / 2
@export var PREDICT: float = 0.5

var target: Node2D = null

func _ready():
	if TARGET_PATH:
		target = get_node_or_null(TARGET_PATH)

func _physics_process(_delta):
	if !target:
		return
	
	var target_x = target.global_position.x + VIEWPORT_WIDTH / 2.5
	if target is CharacterBody2D:
		target_x += target.velocity.x * PREDICT * 0.01
		
	global_position.x = target_x
	global_position.y = yPosition
