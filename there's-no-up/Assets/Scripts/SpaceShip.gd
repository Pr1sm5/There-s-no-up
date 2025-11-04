extends CharacterBody2D

@export var speed : int = 250
@export var rotation_speed : float = 3
@export var health : int = 100
@export var fuel : float = 100
@export var emp_amount : int = 1
@export var bullet_scene : PackedScene
@export var shoot_cooldown : float = 0.25


@onready var detection_area : Area2D = $DetectionArea


var can_shoot : bool = true
var rotation_direction = 0


func _ready() -> void:
	detection_area.body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	move_ship()
	rotate_ship(delta)
	shoot()
	update_from_global()

func _process(delta: float) -> void:
	
	
	return

func move_ship():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var normal_direction = input_direction.normalized().rotated(rotation)
	velocity = normal_direction * speed
	if normal_direction.length() > 0:
		fuel -= 0.05
		update_global()
	move_and_slide()
	

func rotate_ship(delta):
	rotation_direction = Input.get_axis("rotate_left", "rotate_right")
	rotation += rotation_direction * rotation_speed * delta

func shoot():
	if (!Input.is_action_pressed("shoot")):
		return
	if (fuel <= 0):
		return
	if (!can_shoot):
		return
	
	var bullet = bullet_scene.instantiate()
	var offset = 30
	var forward_vector = Vector2.UP.rotated(rotation)
	
	bullet.global_position = global_position + forward_vector * offset
	bullet.rotation = rotation
	get_tree().current_scene.add_child(bullet)
	can_shoot = false
	reset_shoot_cooldown()
	fuel -= 0.5
	
	update_global()

func take_damage(amount: int) -> void:
	health -= amount
	update_global()

func reset_shoot_cooldown():
	await get_tree().create_timer(shoot_cooldown).timeout
	can_shoot = true

func _on_body_entered(body):
	if body.is_in_group("asteroid"):
		take_damage(body.damage)
		body.explode()
		print("Enemy Collision: Health = " + str(health))


func update_global():
	Global.player_health = health
	Global.player_fuel = fuel
	Global.player_emp_amount = emp_amount
	Global.player_position = global_position
	return

func update_from_global():
	health = Global.player_health
	fuel = Global.player_fuel
