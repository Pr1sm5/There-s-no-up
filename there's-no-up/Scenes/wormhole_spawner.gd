extends Node

@export var wormhole : PackedScene

func _ready() -> void:
	call_deferred("random_position")
	return


func random_position():
	var rand_x = randf_range(-500, 500)
	var rand_y = randf_range(300, 600)
	
	var above = randf() < 0.5
	
	if above:
		rand_y *= -1
	
	var hole = wormhole.instantiate()
	hole.global_position = Vector2(rand_x, rand_y)
	hole.change_pos(rand_x, rand_y)
	print(hole.global_position)
	get_parent().add_child(hole)
