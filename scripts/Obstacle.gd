extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name != "Character":
		return
	
	var parent = get_parent()
	if is_instance_valid(parent) and parent.has_method("emitGameOver"):
		parent.emitGameOver()
