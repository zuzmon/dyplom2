extends Node3D

@onready var camera = $player/Head/Camera3D
@onready var player = $player
@onready var biurko = $"stanowisko solo"

var magnitude = 0.2
var period = 0.3
var clicks = 4

func _ready():
	$player.global_position = Global.player_teleport_pos
	$player.rotation = Global.player_teleport_rot
	$player/Head.rotation = Global.head_teleport_rot 
	$player/Head/Camera3D.rotation = Global.cam_teleport_rot

func _camera_shake():
	var initial_transform = camera.transform 
	var elapsed_time = 0.0
	
	while elapsed_time < period:
		var offset = Vector3(
			randf_range(-magnitude, magnitude),
			randf_range(-magnitude, magnitude),
			0.0
		)
	
		camera.transform.origin = initial_transform.origin + offset
		elapsed_time += get_process_delta_time()
		await get_tree().process_frame
	
	camera.transform = initial_transform

func _on_teleport_teleport():
	_camera_shake()
	clicks -= 1
	if clicks <= 0:
		Fade.fade_out("res://sceny/scena 3.tscn")
		clicks = 10
		return
