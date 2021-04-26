extends "res://obstacle/Obstacle.gd"





func _ready():
	speed = 0


func start_cutscene():
	$AnimationPlayer.play("satan")
