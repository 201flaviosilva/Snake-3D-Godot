extends Control

func _draw() -> void:
	_UTILS.draw_checkered(self)


func _on_Play2DBTN_pressed():
	get_tree().change_scene("res://Game2D/Scenes/Game2D.tscn")

func _on_Play3DBTN_pressed():
	print("Game 3D")

func _on_InstructionsBTN_pressed():
	print("Instructions")

func _on_ExitBTN_pressed():
	get_tree().quit()
