extends Node3D

@onready var camera = $player/Head/Camera3D
@onready var player = $player
@onready var biurko = $"stanowisko solo"

var magnitude = 0.1
var period = 0.3
var clicks = 4
var begin_dialog = ["bSzybciej", "bTu do poprawy", "bJeszcze to popraw", "bPilne", "bZle zrobione"]
var dialog_flag = false

func _ready():
	$player.global_position = Global.player_teleport_pos
	$player.rotation = Global.player_teleport_rot
	$player/Head.rotation = Global.head_teleport_rot 
	$player/Head/Camera3D.rotation = Global.cam_teleport_rot

func _camera_shake():
	var initial_transform = camera.transform 
	var elapsed_time = 0.0
	
	while true:
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
	if not dialog_flag:
		dialog_flag = true
		_camera_shake()
		$player.dialog = begin_dialog
		$player.start_dialog(null)

func _on_player_next_line():
	magnitude += 0.05
	$Tiktak.pitch_scale += 0.2

func _on_player_dialog_over():
	#Fade.fade_out("res://sceny/scena 3.tscn")
	get_tree().change_scene_to_file("res://sceny/scena 3.tscn")
