extends Node2D
@onready var ring_sprite = $Ring

func _ready() -> void:
	ring_sprite.rotation = 0
	return

func _process(delta: float) -> void:
	point_to_goal()
	return


func point_to_goal():
	var direction = (Global.player_position - Global.portal_pos).normalized()
	ring_sprite.rotation = direction.angle() + deg_to_rad(-90)
