extends Area2D

func _ready():
	# Ensure input picking is on, if needed. Often Area2D will handle this automatically with its collision shapes.
	input_pickable = true

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			print("Pirate clicked!")
			# Execute any additional logic here.
