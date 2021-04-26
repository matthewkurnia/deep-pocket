extends Node


func start():
	for child in get_children():
		if not child.playing:
			child.play()


func stop():
	for child in get_children():
		child.playing = false


func cosmic():
	$Music.bus = "Cosmic"
