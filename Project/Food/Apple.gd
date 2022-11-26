extends Area2D

var currentColor = ""

var possible_colors = [
#	{"name": "Blue", "texture": preload("res://Assets/Circles/Blue.png")},
	{"name": "Cyan", "texture": preload("res://Assets/Circles/Cyan.png")},
	{"name": "Green", "texture": preload("res://Assets/Circles/Green.png")},
	{"name": "Pink", "texture": preload("res://Assets/Circles/Pink.png")},
	{"name": "Red", "texture": preload("res://Assets/Circles/Red.png")},
	{"name": "White", "texture": preload("res://Assets/Circles/White.png")},
	{"name": "Yellow", "texture": preload("res://Assets/Circles/Yellow.png")}
]

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()
	_random_texture()
	_randomize_position()

func _random_texture() -> void:
	var index = rng.randi_range(0, possible_colors.size() - 1)
	currentColor = possible_colors[index]["name"]
	$Sprite.texture = possible_colors[index]["texture"]

func _randomize_position() -> void:
	var width = ProjectSettings.get_setting("display/window/size/width")
	var height = ProjectSettings.get_setting("display/window/size/height")
	var half_cell = GLOBALS.GRID_SIZE / 2
	var max_x = width / GLOBALS.GRID_SIZE
	var max_y = height / GLOBALS.GRID_SIZE
	
	var x = rng.randi_range(0, max_x) * GLOBALS.GRID_SIZE - half_cell
	x = clamp(x, half_cell, width - half_cell)
	
	var y = rng.randi_range(0, max_y) * GLOBALS.GRID_SIZE - half_cell
	y = clamp(y, half_cell, height - half_cell)
	global_position = Vector2(x, y)


func _on_Apple_area_entered(area: Area2D) -> void:
	if area.is_in_group("player") and area.is_in_group("body"): _randomize_position()

func destroy() -> String:
	queue_free()
	return currentColor
