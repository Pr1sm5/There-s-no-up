extends Node2D

@onready var anim_sprite = $AnimatedSprite2D
@onready var area = $Area2D




func _ready() -> void:
	area.body_entered.connect(_on_body_entered)
	anim_sprite.play("default")
	print("SPAWNING PORTAL")
	Global.portal_pos = global_position

func change_pos(x, y):
	print("SPAWNING PORTAL")
	Global.portal_pos = Vector2(x, y)
	global_position = Vector2(x, y)

func _on_body_entered(body):
	Global.level_index += 1
	get_tree().reload_current_scene()
	return
