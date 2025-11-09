extends Node

@export var asteroid_scene : PackedScene

@export var level = 0
@export var cooldown_time = 0.4
enum TYPE {NORMAL, VOLATILE, BIO, METAL}
var can_spawn = true

var rand_type

func _process(delta: float) -> void:
	randomise_type()
	spawn_asteroid(rand_type)

func reset_spawner():
	await get_tree().create_timer(cooldown_time).timeout
	can_spawn = true

func randomise_type():
	var random_picker = randi_range(0, 100)
	if (random_picker < 70):
		rand_type = TYPE.NORMAL
	elif 70 < random_picker and random_picker < 80:
		rand_type = TYPE.BIO
	elif 80 < random_picker and random_picker < 90:
		rand_type = TYPE.METAL
	elif 90 < random_picker  and random_picker < 100:
		rand_type = TYPE.VOLATILE
	else:
		rand_type = TYPE.NORMAL

func spawn_asteroid(type):
	if !can_spawn:
		return
	can_spawn = false

	var asteroid = asteroid_scene.instantiate()
	asteroid.asteroid_type = type

	# Random X position around the player
	var random_x = randf_range(-600, 600)

	# Randomly spawn above or below
	var spawn_above = randf() < 0.5
	var offset_y = randf_range(400, 600)
	var random_y = -offset_y if spawn_above else offset_y

	# Spawn position
	var spawn_pos = Vector2(
		Global.player_position.x + random_x,
		Global.player_position.y + random_y
	)
	asteroid.global_position = spawn_pos

	# --- DIRECTION & VELOCITY ---
	# Compute direction toward player (with slight randomness)
	var direction = (Global.player_position - spawn_pos).normalized()
	direction = direction.rotated(randf_range(-0.3, 0.3))  # add spread in radians (~±11°)

	# Assign velocity — this depends on how your asteroid moves
	# (assuming your asteroid has a `velocity` variable)
	var speed = randf_range(150, 300)
	asteroid.direction = direction
	var rand_rot = randf_range(0, 360)
	asteroid.rotation = deg_to_rad(rand_rot)

	add_child(asteroid)
	print("Spawning Asteroid at ", spawn_pos, " moving toward player")
	reset_spawner()
