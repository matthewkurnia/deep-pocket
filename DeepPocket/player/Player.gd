extends Node2D


signal take_damage

export var speed := 20.0
export var accel := 0.1

var velocity := 0.0
var dead = false


func _physics_process(delta):
	if dead:
		return
	var dir := -int(Input.is_action_pressed("ui_left")) + int(Input.is_action_pressed("ui_right"))
	velocity = lerp(velocity, dir * speed, accel)
	self.position.x = max(100, min(self.position.x + velocity, 980))


func _on_HurtBox_area_entered(area):
	if area.is_in_group("obstacle"):
		emit_signal("take_damage")
