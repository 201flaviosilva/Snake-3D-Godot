extends Area2D

var possible_colors = [
	{"name": "Black", "texture": preload("res://Assets/Squares/Black.png")},
	{"name": "Blue", "texture": preload("res://Assets/Squares/Blue.png")},
	{"name": "Cyan", "texture": preload("res://Assets/Squares/Cyan.png")},
	{"name": "Green", "texture": preload("res://Assets/Squares/Green.png")},
	{"name": "Grey", "texture": preload("res://Assets/Squares/Grey.png")},
	{"name": "Pink", "texture": preload("res://Assets/Squares/Pink.png")},
	{"name": "Red", "texture": preload("res://Assets/Squares/Red.png")},
	{"name": "White", "texture": preload("res://Assets/Squares/White.png")},
	{"name": "Yellow", "texture": preload("res://Assets/Squares/Yellow.png")}
]


func change_texture(color: String) -> void:
	for i in range(possible_colors.size()):
		if possible_colors[i]["name"] == color:
			$Sprite.texture = possible_colors[i]["texture"]
			return
