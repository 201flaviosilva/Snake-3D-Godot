extends Area2D

signal food_eated
export (float, 0.1, 1) var normal_speed: float = 0.2

var direction: Vector2 = Vector2.RIGHT
var speed: float = normal_speed

onready var BodyPart: PackedScene = preload("res://Player/BodyPart.tscn")
var body = []

func _ready() -> void:
	_set_speed(normal_speed)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("up") and not direction == Vector2.DOWN: direction = Vector2.UP
	if Input.is_action_just_pressed("down") and not direction == Vector2.UP: direction = Vector2.DOWN
	if Input.is_action_just_pressed("left") and not direction == Vector2.RIGHT: direction = Vector2.LEFT
	if Input.is_action_just_pressed("right") and not direction == Vector2.LEFT: direction = Vector2.RIGHT
	
	if Input.is_action_just_pressed("run"): _set_speed(normal_speed / 2)
	elif Input.is_action_just_released("run"): _set_speed(normal_speed)

func _on_Move_timeout() -> void:
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

func _add_body() -> PackedScene:
	var new_body = BodyPart.instance()
	body.append(new_body)
	return new_body

func _on_Player_area_entered(area: Area2D) -> void:
	if area.is_in_group("food"):
		var new_body = _add_body()
		area.call_deferred("_randomize_position")
		emit_signal("food_eated", new_body, Vector2(-100, -100))
	elif area.is_in_group("body"):
		get_tree().reload_current_scene()
