extends Node2D

@export var scroll_speed: float = 200.0  # pixels per second

@onready var sprite1: Sprite2D = $Sprite1
@onready var sprite2: Sprite2D = $Sprite2

func _process(delta: float) -> void:
	# Move both sprites downward
	sprite1.position.y += scroll_speed * delta
	sprite2.position.y += scroll_speed * delta

	# When one sprite moves completely off screen,
	# wrap it above the other to create a seamless loop
	if sprite2.position.y <= Global.player_position.y:
		sprite1.position.y = sprite2.position.y - 2999
		print("replacing sprite 1")
	elif sprite1.position.y >= Global.player_position.y:
		sprite2.position.y = sprite1.position.y - 2999
		print("replacing sprite 2")
