extends Node2D

@export var new_rotation = 0.1

func _process(delta: float) -> void:
	rotation += new_rotation * delta
