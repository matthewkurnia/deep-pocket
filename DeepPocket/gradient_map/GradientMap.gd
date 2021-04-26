extends ColorRect


var gradients = [
	preload("res://gradient_map/GradientNormal.tres"),
	preload("res://gradient_map/GradientWeird.tres"),
	preload("res://gradient_map/GradientOcean.tres"),
	preload("res://gradient_map/GradientHell.tres"),
	preload("res://gradient_map/GradientCosmic.tres")
]


func update_stage(new_stage):
	self.material.set_shader_param("gradient", gradients[new_stage])
