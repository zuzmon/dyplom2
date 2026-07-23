extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_teleport_teleport():
	Global.player_teleport_pos = $player.global_position
	Global.player_teleport_rot = $player.rotation
	Global.head_teleport_rot = $player/Head.rotation
	Global.cam_teleport_rot = $player/Head/Camera3D.rotation
	Fade.fade_out("res://sceny/scena 2.tscn")
