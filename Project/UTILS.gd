extends Node

func draw_checkered(context) -> void:
	var c1 = Color(0.537, 0.635, 0.341)
	var c2 = Color(0.745, 0.863, 0.5)
	
	var width = ProjectSettings.get_setting("display/window/size/width")
	var height = ProjectSettings.get_setting("display/window/size/height")
	var GRID_SIZE = GLOBALS.GRID_SIZE
	
	for x in range(width / GRID_SIZE):
		for y in range(height / GRID_SIZE):
			var color = c1 if (x+y) % 2 == 0 else c2
			var position = Vector2(GRID_SIZE*x, GRID_SIZE*y)
			var rect = Rect2(position.x, position.y, position.x + GRID_SIZE, position.y + GRID_SIZE)
			context.draw_rect(rect, color)
