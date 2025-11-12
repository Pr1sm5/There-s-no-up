extends Node2D

@onready var ring_sprite = $Ring

# --- Zufallsverhalten Variablen ---
var crazy_rotation_speed: float = 0.0
var crazy_direction: int = 1
var crazy_timer := 0.0
var crazy_pause := false

func _ready() -> void:
	ring_sprite.rotation = 0


func _process(delta: float) -> void:
	if Global.level_index == 4:
		crazy_compass_behavior(delta)
	else:
		point_to_goal()


func point_to_goal():
	var direction = (Global.player_position - Global.portal_pos).normalized()
	ring_sprite.rotation = direction.angle() + deg_to_rad(-90)


func crazy_compass_behavior(delta: float) -> void:
	# Countdown für Zufallsverhalten
	crazy_timer -= delta
	
	# Wenn der Timer abgelaufen ist, neues zufälliges Verhalten wählen
	if crazy_timer <= 0:
		crazy_timer = randf_range(0.3, 1.2)   # Nächster Wechsel nach 0.3–1.2 Sek.
		crazy_pause = randf() < 0.25          # 25 % Chance, dass der Kompass kurz stehen bleibt
		crazy_direction = sign(randf_range(-1.0, 1.0))  # -1 oder 1 für Drehrichtung
		crazy_rotation_speed = randf_range(1.0, 6.0) * crazy_direction

	# Wenn „Pause“-Phase aktiv ist, nichts drehen
	if crazy_pause:
		return
	
	# Rotation fortsetzen
	ring_sprite.rotation += crazy_rotation_speed * delta
