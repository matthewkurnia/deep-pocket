extends Node2D


export var game: PackedScene


func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to(game)


func intro_finished():
	get_tree().change_scene_to(game)
