extends Node2D

@export var health = 6
@export var speed

var direction

func _process(delta: float) -> void:
	position += direction * speed * delta

func explode():
	return
