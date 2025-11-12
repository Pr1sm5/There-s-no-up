extends Node2D

@onready var ring_sprite = $Ring


var crazy_rotation_speed: float = 0.0
var crazy_direction: int = 1
var crazy_timer := 0.0
var crazy_pause := false

func _ready() -> void:
	ring_sprite.rotation = 0


func _process(delta: float) -> void:
	if Global.level_index == 4:
		crazy_compass_behavior(delta)
	else:
		point_to_goal()


func point_to_goal():
	var direction = (Global.player_position - Global.portal_pos).normalized()
	ring_sprite.rotation = direction.angle() + deg_to_rad(-90)


func crazy_compass_behavior(delta: float) -> void:

	crazy_timer -= delta
	

	if crazy_timer <= 0:
		crazy_timer = randf_range(0.3, 1.2)   
		crazy_pause = randf() < 0.25          
		crazy_direction = sign(randf_range(-1.0, 1.0)) 
		crazy_rotation_speed = randf_range(1.0, 6.0) * crazy_direction

	
	if crazy_pause:
		return
	
	# Rotation fortsetzen
	ring_sprite.rotation += crazy_rotation_speed * delta
