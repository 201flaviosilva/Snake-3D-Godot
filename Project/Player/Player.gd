extends Area2D

export (float, 0.1, 1) var normal_speed: float = 0.25

const GRID_SIZE = 64
var direction: Vector2 = Vector2.RIGHT
var speed: float = normal_speed

func _ready() -> void:
	_set_speed(normal_speed)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("up"): direction = Vector2.UP
	if Input.is_action_just_pressed("down"): direction = Vector2.DOWN
	if Input.is_action_just_pressed("left"): direction = Vector2.LEFT
	if Input.is_action_just_pressed("right"): direction = Vector2.RIGHT
	
	if Input.is_action_just_pressed("run"): _set_speed(normal_speed / 2)
	elif Input.is_action_just_released("run"): _set_speed(normal_speed)

func _on_Move_timeout() -> void:
	global_position += direction * GRID_SIZE

func _set_speed(value: float) -> void:
	var move_timer = $Move
	speed = value
	move_timer.wait_time = speed
	move_timer.start()
