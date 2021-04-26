extends Node2D


enum Stage {NORMAL, WEIRD, OCEAN, HELL, COSMIC}

var stage = Stage.NORMAL
var obstacle_normal = [
	preload("res://obstacle/normal/Normal1.tscn"),
	preload("res://obstacle/normal/Normal2.tscn"),
	preload("res://obstacle/normal/Normal3.tscn"),
	preload("res://obstacle/normal/Normal4.tscn"),
	preload("res://obstacle/normal/Normal5.tscn"),
	preload("res://obstacle/normal/Normal6.tscn"),
	preload("res://obstacle/normal/Normal7.tscn"),
	preload("res://obstacle/normal/Normal8.tscn")
]
var obstacle_weird = [
	preload("res://obstacle/weird/Weird1.tscn"),
	preload("res://obstacle/weird/Weird2.tscn"),
	preload("res://obstacle/weird/Weird3.tscn"),
	preload("res://obstacle/weird/Weird4.tscn"),
	preload("res://obstacle/weird/Weird5.tscn"),
	preload("res://obstacle/weird/Weird6.tscn"),
	preload("res://obstacle/weird/Weird7.tscn"),
	preload("res://obstacle/weird/Weird8.tscn")
]
var obstacle_ocean = [
	preload("res://obstacle/ocean/Ocean1.tscn"),
	preload("res://obstacle/ocean/Ocean2.tscn"),
	preload("res://obstacle/ocean/Ocean3.tscn"),
	preload("res://obstacle/ocean/Ocean4.tscn"),
	preload("res://obstacle/ocean/Ocean5.tscn"),
	preload("res://obstacle/ocean/Ocean6.tscn"),
	preload("res://obstacle/ocean/Ocean7.tscn"),
	preload("res://obstacle/ocean/Ocean8.tscn")
]
var obstacle_hell = [
	preload("res://obstacle/hell/Hell1.tscn"),
	preload("res://obstacle/hell/Hell2.tscn"),
	preload("res://obstacle/hell/Hell3.tscn"),
	preload("res://obstacle/hell/Hell4.tscn"),
	preload("res://obstacle/hell/Hell5.tscn"),
	preload("res://obstacle/hell/Hell6.tscn"),
	preload("res://obstacle/hell/Hell7.tscn"),
	preload("res://obstacle/hell/Hell8.tscn")
]
var obstacle_cosmic = [
	preload("res://obstacle/cosmic/Cosmic1.tscn"),
	preload("res://obstacle/cosmic/Cosmic2.tscn"),
	preload("res://obstacle/cosmic/Cosmic3.tscn"),
	preload("res://obstacle/cosmic/Cosmic4.tscn"),
	preload("res://obstacle/cosmic/Cosmic5.tscn"),
	preload("res://obstacle/cosmic/Cosmic6.tscn"),
	preload("res://obstacle/cosmic/Cosmic7.tscn"),
	preload("res://obstacle/cosmic/Cosmic8.tscn")
]
var obstacle = []
var len_obstacle = 0
var speed := 10.0
var spawning := false


func _ready():
	update_stage(stage)


func update_speed(new_speed):
	speed = new_speed


func update_stage(new_stage: int):
	stage = new_stage
	match stage:
		Stage.NORMAL:
			obstacle = obstacle_normal
		Stage.WEIRD:
			obstacle = obstacle_weird
		Stage.OCEAN:
			obstacle = obstacle_ocean
		Stage.HELL:
			obstacle = obstacle_hell
		Stage.COSMIC:
			obstacle = obstacle_cosmic
	len_obstacle = obstacle.size()


func set_spawn(value):
	spawning = value
	print(spawning)


func _on_Timer_timeout():
	$Timer.wait_time = 1.0 - 0.5 * (speed/40) + 0.5 * randf()
	$Timer.start()
	if not spawning:
		return
	var i = randi() % len_obstacle
	var obstacle_instance = obstacle[i].instance()
	obstacle_instance.update_speed(speed)
	obstacle_instance.position.y = 2500
	obstacle_instance.position.x = 100 + randf() * 880
	self.add_child(obstacle_instance)
