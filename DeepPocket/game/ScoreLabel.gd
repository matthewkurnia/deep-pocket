extends Label


func update_label(new_value: int) -> void:
	self.text = str(new_value).pad_zeros(3)


func cosmic():
	self.text = "???"
