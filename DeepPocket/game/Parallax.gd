extends CanvasLayer


onready var parallax1 = $Parallax1
onready var parallax2 = $Parallax2
onready var parallax3 = $Parallax3


var speed = 10.0


func _physics_process(delta):
	parallax1.motion_offset.y -= speed
	parallax2.motion_offset.y -= speed * 0.7
	parallax3.motion_offset.y -= speed * 0.4


func update_speed(new_speed):
	speed = new_speed
