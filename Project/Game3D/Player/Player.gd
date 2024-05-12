extends Area

class_name Player

signal food_eated
signal dead

export (float, 0.05, 1) var normal_speed: float = 0.1

var direction: Vector3 = Vector3(0, 0, -1)
var speed: float = normal_speed

onready var MOVE_TIMER: Timer = $Move

func _ready():
	_set_speed(normal_speed)

func _process(delta: float) -> void:
	if get_tree().paused: return;
	look_at(global_transform.origin + direction, Vector3.UP)

func _input(event):
	if event.is_action_pressed("left"):
		if direction.x == -1: direction = Vector3.BACK # Down
		elif direction.x == 1: direction = Vector3.FORWARD # Up
		elif direction.z == -1: direction = Vector3.LEFT # Left
		elif direction.z == 1: direction = Vector3.RIGHT # Right
	
	if event.is_action_pressed("right"):
		if direction.x == -1: direction = Vector3.FORWARD # Up
		elif direction.x == 1: direction = Vector3.BACK # Down
		elif direction.z == -1: direction = Vector3.RIGHT # Right
		elif direction.z == 1: direction = Vector3.LEFT # Left
		
	if event.is_action_pressed("run"): _set_speed(normal_speed / 2)
	elif event.is_action_released("run"): _set_speed(normal_speed)

func _on_Move_timeout() -> void:
	if get_tree().paused: return
	global_translate(direction)
	
func _set_speed(value: float) -> void:
	speed = value
	MOVE_TIMER.wait_time = speed
	MOVE_TIMER.start()
