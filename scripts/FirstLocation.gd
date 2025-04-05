extends Node2D

@onready var OBSTACLE = preload("res://components/Obstacle.tscn")
const VIEWPORT_WIDTH = 1152
const VIEWPORT_HEIGHT = 590

func _ready() -> void:
	var obstacles = generate_obstacles()
	for obstacle in obstacles:
		self.add_child(obstacle)
	
	pass
	
func generate_obstacles() -> Array[Area2D]:
	const LOG_DISTANCE_X = VIEWPORT_WIDTH / 4
	var obstacles: Array[Area2D]  = []
	
	for leftXPosition in range(LOG_DISTANCE_X, LOG_DISTANCE_X * 100, LOG_DISTANCE_X):
		var topScale = randf() * 2 + 1
		var bottomScale = 4.5 - topScale
		
		var obstacleTop: Area2D = OBSTACLE.instantiate()
		obstacleTop.rotate(PI)
		obstacleTop.position = Vector2(leftXPosition, 0)
		obstacleTop.scale = Vector2(1, topScale)
		
		var obstacleBottom: Area2D = OBSTACLE.instantiate()
		obstacleBottom.position = Vector2(leftXPosition, VIEWPORT_HEIGHT)
		obstacleBottom.scale = Vector2(1, bottomScale)
		
		obstacles.push_back(obstacleTop)
		obstacles.push_back(obstacleBottom)
		
	return obstacles


func _on_collisions_body_entered(body: Node2D) -> void:
	if body.name != "Character":
		return
	
	# TODO: Handle collision
	print("Game Over")
