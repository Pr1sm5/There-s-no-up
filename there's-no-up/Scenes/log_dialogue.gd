extends Node2D

@onready var line = $TextEdit
@onready var audio_player = $AudioStreamPlayer  # Add this node in your scene

var text_i = 0
var typing_speed := 0.04  # seconds per character

var level_texts = {
	0: [
		{"text": "Earth time: 15:30 10.08.2222\nExpedition launched.\nObjective: Explore uncharted space.", "duration": 5},
		{"text": "All systems nominal. Life support green. The void feels calm.", "duration": 4},
		{"text": "Captain’s log: We are leaving known space behind.\nNo signals. No echoes. Just silence.", "duration": 5},
	],
	1: [
		{"text": "Unidentified mass detected ahead.\nStructure resembles our own hull design.", "duration": 5},
		{"text": "Closer inspection confirms it…\nIt’s a wreck identical to the *Odyssey*.", "duration": 6},
		{"text": "Crew unsettled. No signs of life. No impact marks.\nJust… decay.", "duration": 5},
	],
	2: [
		{"text": "Multiple wrecks drifting in the same trajectory as ours.", "duration": 5},
		{"text": "Each one is older—metal eroded, names faded.\nSame registry. Same ship.", "duration": 5},
		{"text": "Crew requests return vector.\nNavigation reports no known origin.", "duration": 6},
	],
	3: [
		{"text": "Signals from the wrecks are looping.\nTransmissions identical to our own logs.", "duration": 5},
		{"text": "We tried transmitting a new message.\nIt was received—before we sent it.", "duration": 6},
		{"text": "Perhaps these are not wrecks… but echoes of our path.", "duration": 6}
	],
	4: [
		{"text": "No movement on scanners.\nOnly wrecks—hundreds—each bearing our name.", "duration": 6},
		{"text": "The silence feels heavier than the hull.\nEngines idle. No destination left.", "duration": 6},
		{"text": "Crew whispers about déjà vu.\nBut there’s nowhere to return to.", "duration": 5},
		{"text": "Captain’s final entry:\nWe are not lost in space.\nWe are lost in ourselves.", "duration": 7}
	]
}

func _ready() -> void:
	if Global.level_index in level_texts:
		show_text(Global.level_index, 0)
	else:
		print("No texts for this level")

func _process(delta):
	var line_count = line.get_line_count()
	var line_height = line.get_line_height()
	line.custom_minimum_size.y = line_count * line_height + 8  # padding

# --- TYPEWRITER EFFECT WITH AUDIO ---
func show_text(level, index):
	var texts = level_texts[level]
	if index >= texts.size():
		print("OUT OF TEXTS for level ", level)
		return

	var entry = texts[index]
	text_i = index
	animate_text(entry.text, level, entry.duration if entry.has("duration") else 5)


func animate_text(full_text: String, level: int, duration: float) -> void:
	line.text = ""  # clear
	if audio_player and audio_player.stream:
			audio_player.play()
	for i in full_text.length():
		line.text += full_text[i]

		# --- Play audio for this character ---
		

		await get_tree().create_timer(typing_speed).timeout
	audio_player.stop()
	# Wait remaining duration before showing next text
	await get_tree().create_timer(duration).timeout
	show_text(level, text_i + 1)
