extends Node

@export var wormhole : PackedScene

func _ready() -> void:
	call_deferred("random_position")
	return


func random_position():
	if Global.level_index == 4:
		return
	var rand_x = randf_range(-5000, 5000) * (Global.level_index + 0.5)* 0.5
	var rand_y = randf_range(3000, 6000) * (Global.level_index + 0.5) * 0.5
	
	var above = randf() < 0.5
	
	if above:
		rand_y *= -1
	
	var hole = wormhole.instantiate()
	hole.global_position = Vector2(rand_x, rand_y)
	Global.portal_pos = hole.global_position
	hole.change_pos(rand_x, rand_y)
	print(hole.global_position)
	get_parent().add_child(hole)
	hole.change_pos(rand_x, rand_y)
