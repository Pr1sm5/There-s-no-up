extends Node

var player_default_health = 100
var player_default_fuel = 100
var player_health = 100
var player_fuel = 100
var player_emp_amount = 1
var player_position : Vector2


#PORTAL
var portal_pos : Vector2 = Vector2.ZERO


#Level
var level_index = 0


#Camera
var shake_camera = false

func _process(delta: float) -> void:
	if player_health <= 0:
		get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
		reset_global()


func reset_global():
	player_health = player_default_health
	player_fuel = player_default_fuel
	player_emp_amount = 1
	level_index = 0
	shake_camera = false
	
