extends CanvasLayer

func _ready() -> void:
	hide()

func _on_HomeButton_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene("res://UI/Menu.tscn")
