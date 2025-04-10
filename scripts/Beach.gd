extends CollisionShape2D

var TO_SECOND = "res://scenes/ToSecond.tscn"

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name != "Character":
		return
		
	get_tree().change_scene_to_file(TO_SECOND)
		
