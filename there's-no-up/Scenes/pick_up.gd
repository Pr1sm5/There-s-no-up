extends Node2D

@onready var tex : Texture2D = $Sprite2D.texture
@onready var area : Area2D = $Area2D

@export var tex_fuel : Texture2D
@export var tex_shield : Texture2D
@export var tex_emp : Texture2D

@export var fuel_sound : AudioStreamMP3
@export var shield_sound : AudioStreamMP3
@export var emp_sound : AudioStreamMP3

var explode_speed = 200

var type_int = 0

var direction
var is_exploding = true


func _ready() -> void:
	if type_int == 0:
		$Sprite2D.texture = tex_fuel
		$AudioStreamPlayer.stream = fuel_sound
	elif type_int == 1:
		$Sprite2D.texture = tex_shield
		$AudioStreamPlayer.stream = shield_sound
	elif type_int == 2:
		$Sprite2D.texture = tex_emp
		$AudioStreamPlayer.stream = shield_sound
	explo_timer()
	
	area.body_entered.connect(_on_body_entered)

func _process(delta: float) -> void:
	if is_exploding:
		push_outside(delta)
	if !is_exploding:
		position = position.move_toward(Global.player_position, delta * 600)

func _on_body_entered(body):
	if body.is_in_group("player"):
		$AudioStreamPlayer.pitch_scale = randf_range(0.8, 1.2)
		$AudioStreamPlayer.play()
		
		if type_int == 0:
			Global.player_fuel += 3
			if Global.player_fuel >= 100:
				Global.player_fuel = 100
		elif type_int == 1:
			Global.player_health += 2
			if Global.player_health >= 100:
				Global.player_health = 100
		elif type_int == 2:
			Global.player_emp_amount = 1
		body.update_from_global()
		
		var audio = $AudioStreamPlayer
		remove_child(audio)                # Detach from this node
		get_tree().root.add_child(audio)   # Reparent to scene root (so it's not deleted)
		audio.connect("finished", audio.queue_free)  # Clean it up after it ends
		queue_free()

func push_outside(delta):
	position += direction * explode_speed * delta

func explo_timer():
	await get_tree().create_timer(0.2).timeout
	is_exploding = false
	
