extends Node


onready var ouch = [
	$Sound1,
	$Sound2,
	$Sound3
]


func play_sound():
	var i = randi() % 3
	print(ouch[i].name)
	ouch[i].play()
	$Hurt.play()
