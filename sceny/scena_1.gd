extends Node3D

@onready var raycast = $player/Head/Camera3D/RayCastJumpscare
var last_collider

func _ready():
	randomize()
	$Jumpscare.hide()

func _physics_process(_delta):
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if last_collider == collider:
			return
		else:
			last_collider = collider
		if collider.is_in_group("teddy"):
			jumpscare()

func jumpscare():
	$JumpscareAudio.play()
	$Jumpscare/Control/AnimatedSprite2D.frame = randi() % 5
	$Jumpscare.show()
	$Jumpscare/Timer.start()
	await $Jumpscare/Timer.timeout
	$Jumpscare.hide()

func _on_bathroom_body_entered(_body):
	Global.player_teleport_pos = $player.global_position
	Global.player_teleport_rot = $player.rotation
	Global.head_teleport_rot = $player/Head.rotation
	Global.cam_teleport_rot = $player/Head/Camera3D.rotation
	Fade.fade_out("res://sceny/scena 2.tscn")
