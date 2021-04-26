extends Node2D


signal depth_updated(new_depth)
signal health_updated(new_health)
signal speed_updated(new_speed)
signal stage_updated(new_stage)

export var initial_speed = 15.0
export var player = NodePath()
export var depth_label = NodePath()
export var health_label = NodePath()
export var parallax = NodePath()
export var obstacle_spawner = NodePath()
export var satan = NodePath()
export var hurt_anim = NodePath()
export var player_hurt = NodePath()
export var flash_anim = NodePath()
export var tutorial_anim = NodePath()
export var gradient = NodePath()
export var endgame = NodePath()
export var hurt_sound = NodePath()
export var key_anim = NodePath()
var outro = "res://intro/Outro.tscn"

var health := 9
var depth := 0
var speed := 15.0
var game_started = false
var bottom_reached := false

onready var hurt_timer = $HurtTimer


func _input(event):
	if not game_started and (Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right")):
		Sound.start()
		game_started = true
		obstacle_spawner.set_spawn(true)
		tutorial_anim.play("fade_out")


func _ready():
	player = get_node(player)
	player.connect("take_damage", self, "take_damage")
	depth_label = get_node(depth_label)
	health_label = get_node(health_label)
	parallax = get_node(parallax)
	obstacle_spawner = get_node(obstacle_spawner)
	satan = get_node(satan)
	hurt_anim = get_node(hurt_anim)
	player_hurt = get_node(player_hurt)
	flash_anim = get_node(flash_anim)
	flash_anim.play_backwards("change_stage")
	gradient = get_node(gradient)
	tutorial_anim = get_node(tutorial_anim)
	endgame = get_node(endgame)
	hurt_sound = get_node(hurt_sound)
	key_anim = get_node(key_anim)
	self.connect("depth_updated", depth_label, "update_label")
	emit_signal("depth_updated", depth)
	self.connect("health_updated", health_label, "update_label")
	emit_signal("health_updated", health)
	self.connect("speed_updated", parallax, "update_speed")
	self.connect("speed_updated", obstacle_spawner, "update_speed")
	emit_signal("speed_updated", speed)
	self.connect("stage_updated", obstacle_spawner, "update_stage")
	self.connect("stage_updated", gradient, "update_stage")
	emit_signal("stage_updated", 0)


func take_damage() -> void:
	if hurt_timer.time_left > 0:
		return
	hurt_sound.play_sound()
	hurt_timer.start()
	player_hurt.play("hurt")
	health -= 1
	emit_signal("health_updated", health)
	hurt_anim.play("hurt")
	if health == 0:
		game_over()


func game_over() -> void:
	player.dead = true
	yield(get_tree().create_timer(2.0), "timeout")
	get_tree().paused = true
	endgame.visible = true
	yield(get_tree().create_timer(1.5), "timeout")
	flash_anim.play("change_stage")
	yield(flash_anim, "animation_finished")
	get_tree().paused = false
	get_tree().reload_current_scene()
	print("Game over.")


func update_speed(value = -1) -> void:
	if value >= 0:
		speed = value
	else:
		speed = initial_speed + depth/50 * initial_speed * 0.12
	for obstacle in get_tree().get_nodes_in_group("obstacle"):
		obstacle.update_speed(speed)
	emit_signal("speed_updated", speed)


func update_stage(cosmic = false) -> void:
	flash_anim.play("change_stage")
	yield(flash_anim, "animation_finished")
	flash_anim.play_backwards("change_stage")
	if not cosmic:
		emit_signal("stage_updated", depth / 150)
	else:
		emit_signal("stage_updated", 4)
		depth_label.cosmic()
		Sound.cosmic()
		obstacle_spawner.set_spawn(true)
		update_speed(45)
		key_anim.play("key")
		yield(key_anim, "animation_finished")
		flash_anim.play("change_stage")
		yield(flash_anim, "animation_finished")
		Sound.stop()
		get_tree().change_scene(outro)


func _on_DepthTimer_timeout():
	if bottom_reached:
		return
	if game_started:
		depth += 1
		emit_signal("depth_updated", depth)
		if depth % 50 == 0 and depth < 600:
			update_speed()
		if depth % 150 == 0 and depth < 600:
			update_stage()
		match depth:
			600:
				update_speed(45)
				obstacle_spawner.set_spawn(false)
			620:
				satan.add_to_group("obstacle")
				update_speed(30)
			640:
				update_speed(15)
			650:
				update_speed(10)
			657:
				update_speed(5)
			666:
				bottom_reached = true
				satan.start_cutscene()
				update_speed(0)


func _on_Satan_animation_finished(anim_name):
	update_stage(true)
