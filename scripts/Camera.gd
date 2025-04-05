extends Camera2D

const VIEWPORT_WIDTH = 1152
const VIEWPORT_HEIGHT = 590
@export var target_path: NodePath = "../Character"
@export var y_position: float = VIEWPORT_HEIGHT / 2
@export var lookahead_factor: float = 0.5  # How far ahead to look

var target: Node2D = null

func _ready():
	# Get reference to the target node
	if target_path:
		target = get_node_or_null(target_path)

func _physics_process(_delta):
	if target:
		# Only follow in the x direction
		var target_x = target.global_position.x + VIEWPORT_WIDTH / 2.5
		
		# Add some lookahead based on character velocity
		if target is CharacterBody2D:
			target_x += target.velocity.x * lookahead_factor * 0.01
		
		# Update only the x position, keep y fixed
		global_position.x = target_x
		global_position.y = y_position
