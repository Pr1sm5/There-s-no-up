extends Node2D

@onready var shape = $Area2D/CollisionShape2D
@onready var sprite = $Sprite2D
@onready var area = $Area2D
@onready var anim_sprite = $AnimatedSprite2D

@export var start_rad = 1

func _ready() -> void:
	area.body_entered.connect(_on_body_entered)
	shape.shape = shape.shape.duplicate()
	anim_sprite.animation_finished.connect(_on_animation_finished)
	anim_sprite.play()
	$AudioStreamPlayer.play()

func _process(delta: float) -> void:
	shape.shape.radius+= 3.3

	sprite.scale.x += 0.015
	sprite.scale.y += 0.015
	sprite.modulate.a = 0.5


func _on_body_entered(body):
	if body.is_in_group("player"):
		return
	body.explode()

func _on_animation_finished():
	var audio = $AudioStreamPlayer
	remove_child(audio)                # Detach from this node
	get_tree().root.add_child(audio)   # Reparent to scene root (so it's not deleted)
	audio.connect("finished", audio.queue_free)  # Clean it up after it ends
	queue_free()
