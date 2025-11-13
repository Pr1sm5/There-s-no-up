extends Button

func _ready() -> void:
	self.pressed.connect(_on_button_pressed)

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/main_scene.tscn")
	Global.reset_global()
