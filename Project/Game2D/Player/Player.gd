extends Area2D

signal food_eated
signal dead

export (float, 0.1, 1) var normal_speed: float = 0.2

var direction: Vector2 = Vector2.RIGHT
var speed: float = normal_speed

onready var BodyPart: PackedScene = preload("res://Game2D/Player/BodyPart.tscn")
var body = []

func _ready() -> void:
	_set_speed(normal_speed)
	pass

func _process(delta: float) -> void:
	if get_tree().paused: return  
	
	# This will get the direction of the fist body position
	var fix_direction = direction if not body.size() else (global_position - body[0].global_position) / GLOBALS.GRID_SIZE
	
	if Input.is_action_just_pressed("up") and not fix_direction == Vector2.DOWN: 
		direction = Vector2.UP
		$Sprite.rotation_degrees = -90
	if Input.is_action_just_pressed("down") and not fix_direction == Vector2.UP: 
		direction = Vector2.DOWN
		$Sprite.rotation_degrees = 90
	if Input.is_action_just_pressed("left") and not fix_direction == Vector2.RIGHT: 
		direction = Vector2.LEFT
		$Sprite.rotation_degrees = 180
	if Input.is_action_just_pressed("right") and not fix_direction == Vector2.LEFT: 
		direction = Vector2.RIGHT
		$Sprite.rotation_degrees = 0
	
	if Input.is_action_just_pressed("run"): _set_speed(normal_speed / 2)
	elif Input.is_action_just_released("run"): _set_speed(normal_speed)

func _on_Move_timeout() -> void:
	if get_tree().paused: return
	for i in range(body.size() - 1, 0, -1):
		body[i].global_position = body[i - 1].global_position
		
	var lastHeadPosition = global_position
	global_position += direction * GLOBALS.GRID_SIZE
	
	if body.size(): body[0].global_position = lastHeadPosition
	
	_fix_out_border_position()

func _fix_out_border_position() -> void:
	var half_cell = GLOBALS.GRID_SIZE / 2
	var max_x = ProjectSettings.get_setting("display/window/size/width") - half_cell
	var max_y = ProjectSettings.get_setting("display/window/size/height") - half_cell
	
	if global_position.x > max_x: global_position.x = half_cell
	elif global_position.x < 0: global_position.x = max_x
	
	if global_position.y > max_y: global_position.y = half_cell
	elif global_position.y < 0: global_position.y = max_y

func _set_speed(value: float) -> void:
	var move_timer = $Move
	speed = value
	move_timer.wait_time = speed
	move_timer.start()

func _add_body(new_body_color: Color) -> PackedScene:
	var new_body = BodyPart.instance()
	if new_body.has_method("change_texture"): new_body.call_deferred("change_texture", new_body_color)
	body.append(new_body)
	return new_body

func _body_gradient_color() -> void:
	var color_steep = 1 / float(body.size())
	
	for i in range(body.size()):
		var value = color_steep * (i + 1);
		var c = Color(0, value, 0, 1)
		body[i].call_deferred("change_texture", c)

func _on_Player_area_entered(area: Area2D) -> void:
	if area.is_in_group("food"):
		var new_body_color = area.destroy()
		var new_body = _add_body(new_body_color)
		emit_signal("food_eated", new_body, Vector2(-100, -100))
		_body_gradient_color()
	elif area.is_in_group("body") or area.is_in_group("wall"):
		emit_signal("dead")
