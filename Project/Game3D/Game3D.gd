extends Spatial

var score: int = 0
var is_game_over: bool = false

onready var CAMERA: Camera = $Camera
onready var CAMERA_TARGET: Position3D = $"Player/Camera Target"
onready var PLAYER: Player = $Player

func _ready():
	CAMERA.look_at(CAMERA_TARGET.global_transform.origin, Vector3.UP)
	CAMERA.translation = CAMERA.translation.rotated(Vector3.UP, deg2rad(-45))

func _process(delta: float) -> void:
	if get_tree().paused: return;
	
	var camera_position = CAMERA_TARGET.global_transform.origin - PLAYER.direction * 10
	CAMERA.translation = camera_position
	CAMERA.look_at(CAMERA_TARGET.global_transform.origin, Vector3.UP)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if is_game_over:
			get_tree().paused = false
			get_tree().reload_current_scene()
		else: _pause()

func _pause() -> void:
	get_tree().paused = !get_tree().paused
	$Pause.show() if get_tree().paused else $Pause.hide()
