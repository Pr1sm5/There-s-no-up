extends Node2D

@onready var detection_area : Area2D = $DetectionArea

var active : bool = true
var speed : float = 600
var damage : int = 5

var direction = Vector2.ZERO

func _ready() -> void:
	detection_area.body_entered.connect(_on_body_entered)
	direction = Vector2.UP.rotated(rotation)

func _physics_process(delta: float) -> void:
	if active:
		position += direction * speed * delta

func _on_body_entered(body):
	print("SMTH HIT")
	if body.is_in_group("asteroid"):
		print("Bullet hit asteroid!")
		queue_free()
		body.take_damage(3)
	return
