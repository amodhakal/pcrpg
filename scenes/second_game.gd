extends Node2D

# Load the custom crosshair texture.
var crosshair_texture = preload("res://images/crosshair.png")
var crosshair_sprite: Sprite2D

func _ready():
	# Hide the system cursor.
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	# Create the sprite for the crosshair.
	crosshair_sprite = Sprite2D.new()
	crosshair_sprite.texture = crosshair_texture
	add_child(crosshair_sprite)

func _process(delta):
	# Update the crosshair position to where the mouse is.
	crosshair_sprite.position = get_viewport().get_mouse_position()
