extends Node3D

@onready var camera = $player/Head/Camera3D
@onready var player = $player
@onready var biurko = $"stanowisko solo"

var magnitude = 0.0

func _ready():
	$player.global_position = Global.player_teleport_pos
	$player.rotation = Global.player_teleport_rot
	$player/Head.rotation = Global.head_teleport_rot 
	$player/Head/Camera3D.rotation = Global.cam_teleport_rot

func _physics_process(_delta):
	var distance = biurko.global_position.distance_to(player.global_position)
	magnitude = clamp(-0.0215054 * distance + 0.4, 0.0, 0.4)
	_camera_shake()

func _camera_shake():
	var initial_transform = camera.transform 
	while true:
		var offset = Vector3(
			randf_range(-magnitude, magnitude),
			randf_range(-magnitude, magnitude),
			0.0
		)
		camera.transform.origin = initial_transform.origin + offset
		await get_tree().process_frame
	camera.transform = initial_transform

func _on_teleport_teleport():
	Fade.fade_out("res://sceny/scena 3.tscn")
