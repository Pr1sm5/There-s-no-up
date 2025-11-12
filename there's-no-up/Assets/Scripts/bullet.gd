extends Node2D

@onready var detection_area : Area2D = $DetectionArea
@export var tex : Texture2D
@export var tex2: Texture2D
@export var tex3: Texture2D

var all_tex = []

var is_chunk = false

var active : bool = true
var speed : float = 600
var damage : int = 5

var direction = Vector2.ZERO
var one_timer = true

func _ready() -> void:
	all_tex = [
		tex,
		tex2,
		tex3
	]
	detection_area.body_entered.connect(_on_body_entered)
	direction = Vector2.UP.rotated(rotation)
	$AudioStreamPlayer.pitch_scale = randf_range(0.9, 1.1)
	
	
	$AudioStreamPlayer.play()
	
	

func _physics_process(delta: float) -> void:
	if one_timer:
		if is_chunk:
			$AudioStreamPlayer.pitch_scale = randf_range(0.2, 0.4)
		pick_random_texture()
		one_timer = false
	
	if active:
		position += direction * speed * delta
	if is_chunk:
		rotation += 0.02

func _on_body_entered(body):
	print("SMTH HIT")
	if body.is_in_group("asteroid") and !is_chunk:
		print("Bullet hit asteroid!")
		queue_free()
		body.take_damage(3)
	if body.is_in_group("player") and is_chunk:
		print("Bullet hit asteroid!")
		queue_free()
		body.take_damage(5)
	return

func pick_random_texture():
	if !is_chunk:
		return
	
	var rand_int = randi_range(0, 2)
	$Sprite2D.texture = all_tex[rand_int]
	$Sprite2D.scale *= 0.2

func explode():
	var audio = $AudioStreamPlayer
	remove_child(audio)                # Detach from this node
	get_tree().root.add_child(audio)   # Reparent to scene root (so it's not deleted)
	audio.connect("finished", audio.queue_free)  # Clean it up after it ends
	queue_free()
