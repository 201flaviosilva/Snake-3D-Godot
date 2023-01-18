extends Spatial

var score: int = 0
var is_game_over: bool = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if is_game_over:
			get_tree().paused = false
			get_tree().reload_current_scene()
		else: _pause()

func _pause() -> void:
	get_tree().paused = !get_tree().paused
	$Pause.show() if get_tree().paused else $Pause.hide()
