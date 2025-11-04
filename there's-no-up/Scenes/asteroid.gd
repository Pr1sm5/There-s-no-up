extends StaticBody2D

enum {NORMAL, VOLATILE, BIO, METAL}
@export var normal_image: Texture2D = preload("res://Assets/Sprites/asteroid2.png")

@export var health : int = 3
@export var damage : int = 5
@export var base_speed : float = 250
@export var speed : float = 150
@export var direction : Vector2 = Vector2(0, 1)

@export_group("BIO-Asteroids")
@export var bio_image: Texture2D = preload("res://Assets/Sprites/asteroid4.png")
@export var type_bio : int = 10 # Amount of fuel the player gets
@export var bio_health : int = 6
@export var bio_speed : float = 80

@export_group("Metal-Asteroids")

@export var type_metal :int = 10  # Amount of health the player gets
@export var metal_health : int = 9
@export var metal_speed : float = 80

@export_group("Voletile-Asteroids")
@export var volatile_image: Texture2D = preload("res://Assets/Sprites/asteroid3.png")
@export var type_voletile : int = 10 # Projectile Count
@export var voletile_health : int = 1
@export var voletile_speed : float = 80
@export var voletile_timer : float = 5
@export var chunk_scene: PackedScene

@onready var sprite = $Sprite2D

var min_scale = 0.3
var max_scale = 1.5

var asteroid_type = NORMAL



func _ready() -> void:
	randomise_scale()
	change_type()
	print(str(asteroid_type))

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func take_damage(amount: int) -> void:
	health -= amount
	
	if health <= 0:
		if asteroid_type == BIO:
			Global.player_fuel += type_bio
		if asteroid_type == METAL:
			Global.player_health += type_metal
		queue_free()

func randomise_scale():
	var new_scale = randf_range(min_scale, max_scale)
	scale = Vector2(new_scale, new_scale)
	
	speed = base_speed * (max_scale / new_scale)

func explode():
	queue_free()

func volatile_exploder():
	if asteroid_type != VOLATILE:
		return
	await get_tree().create_timer(voletile_timer).timeout
	

func change_type():
	if asteroid_type == NORMAL:
		return
	
	if asteroid_type == BIO:
		health = bio_health
		speed = bio_speed
		scale = Vector2(1,1)
		sprite.texture = bio_image
	
	if asteroid_type == METAL:
		health = metal_health
		speed = metal_speed
		scale = Vector2(1,1)
		sprite.texture = normal_image
		sprite.modulate.r = 1.2
	
	if asteroid_type == VOLATILE:
		health = voletile_health
		speed = voletile_speed
		scale = Vector2(1,1)
		sprite.texture = volatile_image
