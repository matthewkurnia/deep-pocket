extends Node2D


var dir = 1


func _ready():
	dir = -1 + 2 * (randi() % 2)


func _physics_process(delta):
	if get_parent().position.x > 980:
		dir = -1
	elif get_parent().position.x < 100:
		dir = 1
	get_parent().position.x += dir * 10
