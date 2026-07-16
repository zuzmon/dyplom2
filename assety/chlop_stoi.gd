extends Node3D

@onready var anim_player = $AnimationPlayer

func _ready() -> void:
	anim_player.play("mixamo_com")
	anim_player.get_animation("mixamo_com").loop_mode = Animation.LOOP_LINEAR
