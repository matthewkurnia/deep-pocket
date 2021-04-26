extends Area2D


export var speed = 10.0


func _physics_process(delta):
	self.global_position.y -= speed
	if self.global_position.y < -500:
		self.queue_free()


func update_speed(new_speed: float):
	speed = new_speed
