extends Sprite2D

@export var l1_sprite : Texture2D
@export var l2_sprite : Texture2D
@export var l3_sprite : Texture2D
@export var l4_sprite : Texture2D
@export var l5_sprite : Texture2D

@onready var tex = self.texture


var all_sprites = []

func _ready() -> void:
	all_sprites = [
		l1_sprite,
		l2_sprite,
		l3_sprite,
		l4_sprite,
		l5_sprite
	]
	
	choose_sprite()

func choose_sprite():
	if Global.level_index + 1 > all_sprites.size():
		return
	self.texture = all_sprites[Global.level_index]
	
