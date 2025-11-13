extends Node2D

@onready var start_layer : CanvasLayer = $StartLayer
@onready var help_layer : CanvasLayer = $HelpLayer
@onready var help_button : Button = $StartLayer/Helpbutton
@onready var back_button : Button = $HelpLayer/Back

func _ready() -> void:
	
	help_layer.visible = false
	help_button.pressed.connect(_on_help_pressed)
	back_button.pressed.connect(_on_back_pressed)

func _on_help_pressed():
	help_layer.visible = true
	start_layer.visible = false

func _on_back_pressed():
	help_layer.visible = false
	start_layer.visible = true
