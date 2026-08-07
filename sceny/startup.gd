extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_video_stream_player_finished():
	get_tree().change_scene_to_file("res://sceny/letsgo.tscn")
