extends Label


onready var animation_player = $AnimationPlayer


func update_label(new_value: int) -> void:
	self.text = str(new_value)
	animation_player.play("hurt")
