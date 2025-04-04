extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name != "Character":
		return
	
	# TODO: Handle collision
	print("Game Over")
