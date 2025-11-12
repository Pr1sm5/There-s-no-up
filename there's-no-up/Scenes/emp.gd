extends Sprite2D

func _process(delta: float) -> void:
	if Global.player_emp_amount <= 0:
		modulate = Color(0,0,0,1)
	else:
		modulate = Color(1,1,1,1)
