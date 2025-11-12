extends Node2D

@onready var anim_sprite = $AnimatedSprite2D
@onready var area = $Area2D


func _ready() -> void:
	global_position = Vector2(1000.0,1000.0)
	area.body_entered.connect(_on_body_entered)
	anim_sprite.play("default")
	print("SPAWNING PORTAL")
	Global.portal_pos = global_position

func _process(delta: float) -> void:
	var player = get_tree().get_first_node_in_group("player")
	if player:
		audio_volume_scaler(player)

func change_pos(x, y):
	print("SPAWNING PORTAL")
	Global.portal_pos = Vector2(x, y)
	global_position = Vector2(x, y)

func _on_body_entered(body):
	Global.level_index += 1
	get_tree().reload_current_scene()
	return


func audio_volume_scaler(player: Node2D):
	if not is_instance_valid(player):
		return
	
	var max_hear_distance := 3000  
	var min_hear_distance := 50.0 
	
	var distance := global_position.distance_to(player.global_position)
	
	distance = clamp(distance, min_hear_distance, max_hear_distance)
	
	var volume_db: float = lerp(-10.0, -60.0, (distance - min_hear_distance) / (max_hear_distance - min_hear_distance))	
	$AudioStreamPlayer.volume_db = volume_db
