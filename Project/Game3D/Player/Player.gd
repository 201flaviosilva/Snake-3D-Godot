extends Area

signal food_eated
signal dead

export (float, 0.1, 1) var normal_speed: float = 0.2

var direction: Vector3 = Vector3.FORWARD
var speed: float = normal_speed


func _ready() -> void:
	_set_speed(normal_speed)
	pass

func _process(delta: float) -> void:
	if get_tree().paused: return  

	if Input.is_action_just_pressed("up"): 
		direction = Vector3.FORWARD
		rotation_degrees.y = 0
		
	if Input.is_action_just_pressed("down"): 
		direction = Vector3.BACK
		rotation_degrees.y = 180
		
	if Input.is_action_just_pressed("left"): 
		direction = Vector3.LEFT
		rotation_degrees.y = 90
		
	if Input.is_action_just_pressed("right"): 
		direction = Vector3.RIGHT
		rotation_degrees.y = -90

	if Input.is_action_just_pressed("run"): _set_speed(normal_speed / 2)
	elif Input.is_action_just_released("run"): _set_speed(normal_speed)

func _on_Move_timeout() -> void:
	if get_tree().paused: return
	global_translation += direction
	
func _set_speed(value: float) -> void:
	var move_timer = $Move
	speed = value
	move_timer.wait_time = speed
	move_timer.start()
