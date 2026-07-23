extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	$player.global_position = Global.player_teleport_pos
	$player.rotation = Global.player_teleport_rot
	$player/Head.rotation = Global.head_teleport_rot 
	$player/Head/Camera3D.rotation = Global.cam_teleport_rot
