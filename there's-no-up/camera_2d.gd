extends Camera2D
@export var random_strength : float = 10
@export var shake_fade : float = 5.0
@export var shake_time : float = 0.5

var rng = RandomNumberGenerator.new()

var shake_strength :float  = 0.0

var timer2 : Timer

var set_player_at_beginning = false

func _ready():
	return
	


func apply_shake():
	shake_strength = random_strength

func _process(delta: float) -> void:
	if (Global.shake_camera):
		apply_shake()
		
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0, shake_fade * delta)
		offset = random_offset()
		
	if timer2 != null and !timer2.is_stopped():
			return
	else:
		deactivate_shake()
		
	


func random_offset():
	return Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength))
	

func deactivate_shake():
	var timer = Timer.new()
	timer.wait_time = shake_time
	timer.timeout.connect(_on_timer_end, )
	timer.one_shot = true
	add_child(timer)
	timer.start()
	timer2 = timer

func _on_timer_end():
	Global.shake_camera = false
