extends Node

@export var asteroid_scene: PackedScene
@export var level := 0
@export var cooldown_time := 0.4

enum TYPE { NORMAL, VOLATILE, BIO, METAL, SHIPWRECK }

var can_spawn := true
var rand_type: TYPE

func _process(delta: float) -> void:
	randomise_type()
	spawn_asteroid(rand_type)

func reset_spawner():
	if Global.level_index >= 4:
		cooldown_time = 1.2
	await get_tree().create_timer(cooldown_time).timeout
	can_spawn = true

func randomise_type():
	var level_index = clamp(Global.level_index, 0, 4)
	var random_picker := randi_range(0, 100)
	
	# --- BASE CHANCES ---
	var bio_chance = max(12 - level_index * 3, 2)       # 15 → 12 → 9 → 6 → 2
	var metal_chance = max(10 - level_index * 3, 2)     # 10 → 7 → 4 → 2 → 2
	var volatile_chance = 10 + level_index * 3          # 10 → 13 → 16 → 19 → 22
	var shipwreck_chance := -1
	
	# Shipwrecks only start spawning from level 3 onwards
	if level_index == 2:
		shipwreck_chance = 8  # adjust this weight to make them rarer or more frequent
	if level_index == 3:
		shipwreck_chance = 12  # adjust this weight to make them rarer or more frequent
	if level_index == 4:
		shipwreck_chance = 100
		bio_chance = 0
		metal_chance = 0
		volatile_chance = 0

	var normal_chance = 100 - (bio_chance + metal_chance + volatile_chance + shipwreck_chance)
	
	# --- PROBABILITY BANDS ---
	if random_picker < normal_chance:
		rand_type = TYPE.NORMAL
	elif random_picker < normal_chance + bio_chance:
		rand_type = TYPE.BIO
	elif random_picker < normal_chance + bio_chance + metal_chance:
		rand_type = TYPE.METAL
	elif random_picker < normal_chance + bio_chance + metal_chance + volatile_chance:
		rand_type = TYPE.VOLATILE
	else:
		rand_type = TYPE.SHIPWRECK


func spawn_asteroid(type):
	# no spawns beyond level 4 (end of planned levels)
	if Global.level_index > 4:
		return
	
	if not can_spawn:
		return
	can_spawn = false

	var asteroid = asteroid_scene.instantiate()
	asteroid.asteroid_type = type

	# --- RANDOM POSITION ---
	var random_x := randf_range(-600, 600)
	var spawn_above := randf() < 0.5
	var offset_y := randf_range(400, 600)
	var random_y := -offset_y if spawn_above else offset_y

	var spawn_pos := Vector2(
		Global.player_position.x + random_x,
		Global.player_position.y + random_y
	)
	asteroid.global_position = spawn_pos

	# --- DIRECTION & ROTATION ---
	var direction := (Global.player_position - spawn_pos).normalized()
	direction = direction.rotated(randf_range(-0.3, 0.3))
	var speed = randf_range(150, 300)
	asteroid.direction = direction
	asteroid.rotation = deg_to_rad(randf_range(0, 360))

	add_child(asteroid)
	print("Spawning Asteroid:", type, "at", spawn_pos)
	reset_spawner()
