extends Node2D

@onready var line = $TextEdit

var text_i = 0

# Dictionary: level_index -> list of texts
var level_texts = {
	0: [
		{"text": "Earth time: 15:30 10.08.2222\nExpedition started\nGoal: Find out what's out here.", "duration": 5},
		{"text": "All systems nominal. Life support functioning.", "duration": 3},
		{"text": "Captain log: We are drifting into uncharted space.\nThe stars feel different here.", "duration": 5},
	],
	1: [
		{"text": "Strange readings on the scanners… \nsomething familiar is out there.", "duration": 5},
		{"text": "Wait… is that a ship? It looks like ours… destroyed.", "duration": 6},
		{"text": "Time feels… off. Are we moving backward?", "duration": 4},
	],
	2: [
		{"text": "Crew is anxious. \nMemories of past missions blur together.", "duration": 5},
		{"text": "Another ship… same model, same markings… \nabandoned in silence.", "duration": 5},
		{"text": "I see a reflection of myself on the scanners… \nor a version of me lost in space.", "duration": 6},
	],
	3: [
		{"text": "Stars look older… yet some constellations are younger.", "duration": 5},
		{"text": "Empty corridors… drifting wrecks… \nall echoes of our own ship.", "duration": 5},
		{"text": "Goal: Keep moving forward… \nor am I chasing fragments of time?", "duration": 6}
	]
	# Add more levels as needed
}

func _ready() -> void:
	if Global.level_index in level_texts:
		show_text(Global.level_index, 0)
	else:
		print("No texts for this level")

func _process(delta):
	# Adjust TextEdit height to fit content
	var line_count = line.get_line_count()
	var line_height = line.get_line_height()
	line.custom_minimum_size.y = line_count * line_height + 8  # padding

# Show text at index for a given level
func show_text(level, index):
	var texts = level_texts[level]
	if index >= texts.size():
		print("OUT OF TEXTS for level ", level)
		return

	var entry = texts[index]
	line.text = entry.text
	text_i = index
	var duration = 0
	if entry.has(duration):
		duration = entry.duration
	else:
		duration = 5
	start_timer(level, duration)

# Timer to automatically show the next text
func start_timer(level, duration):
	await get_tree().create_timer(duration).timeout
	show_text(level, text_i + 1)
