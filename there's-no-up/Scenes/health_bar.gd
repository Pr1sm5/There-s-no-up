extends ProgressBar

func _ready() -> void:
	max_value = Global.player_default_health

func _physics_process(delta: float) -> void:
	value = Global.player_health
