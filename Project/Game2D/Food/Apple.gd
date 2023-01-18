extends Area2D

var currentColor = Color(1, 1, 1, 1)

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()
	_randomize_position()

func _random_texture() -> void:
	currentColor =  Color(rng.randf(), rng.randf(), rng.randf(), 1)
	$Sprite.modulate = currentColor

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
	if (area.is_in_group("player") and area.is_in_group("body")) or area.is_in_group("wall") or area.is_in_group("food"):
		_randomize_position()

func destroy() -> Color:
	queue_free()
	return currentColor

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "Spawn":
		$AnimationPlayer.play("idle")
		_random_texture()
	
