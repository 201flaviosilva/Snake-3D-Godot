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
	$Pause/Label.text = "Game Over"
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
