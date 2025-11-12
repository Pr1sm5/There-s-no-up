extends Node2D

@onready var tex : Texture2D = $Sprite2D.texture
@onready var area : Area2D = $Area2D

@export var tex_fuel : Texture2D
@export var tex_shield : Texture2D

var type_bool = false

func _ready() -> void:
	if type_bool:
		tex = tex_fuel
	else:
		tex = tex_shield
	
	area.body_entered.connect(_on_body_entered)

func _process(delta: float) -> void:
	position = position.move_toward(Global.player_position, delta * 600)

func _on_body_entered(body):
	if body.is_in_group("player"):
		if type_bool:
			Global.player_fuel += 10
		else:
			Global.player_health += 10
