extends ProgressBar

func _ready() -> void:
	max_value = Global.player_default_fuel

func _physics_process(delta: float) -> void:
	value = Global.player_fuel
