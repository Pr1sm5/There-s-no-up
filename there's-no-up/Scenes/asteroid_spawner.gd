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
	var random_x = randf_range(-600, 600)
	asteroid.global_position = Vector2(Global.player_position.x + random_x , Global.player_position.y - 400)
	add_child(asteroid)
	print("Spawning Asteroid")
	reset_spawner()
