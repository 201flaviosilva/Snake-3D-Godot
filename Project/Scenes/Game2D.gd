extends Node2D

var score: int = 0
var is_game_over: bool = false

onready var foodScene: PackedScene = preload("res://Food/Apple.tscn")

func _on_Player_food_eated(new_body, position: Vector2) -> void:
	score += 1
	$Score.text = str(score)
	$BodyPartsContainer.call_deferred("add_child", new_body)
	new_body.global_position = position

func _on_Player_dead() -> void:
	is_game_over = true
	$Pause/Label.text = "Game Over\n<Esc>"
	_pause()

func _on_NewFood_timeout() -> void:
	if not get_tree().paused:
		var new_food = foodScene.instance()
		$FoodContainer.call_deferred("add_child", new_food)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if is_game_over:
			get_tree().paused = false
			get_tree().reload_current_scene()
		else: _pause()

func _pause() -> void:
	get_tree().paused = !get_tree().paused
	$Pause.show() if get_tree().paused else $Pause.hide()

func _draw() -> void:
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
			draw_rect(rect, color)
