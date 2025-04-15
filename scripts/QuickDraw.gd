extends Node
var time


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	time = randf_range(0.0, 5.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
