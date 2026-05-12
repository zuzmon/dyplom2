extends Node3D

@export var scene := 1

func interact():
	match scene:
		1:
			Fade.fade_out("res://sceny/scena 1.tscn")
		2:
			Fade.fade_out("res://sceny/scena 2.tscn")
		3:
			Fade.fade_out("res://sceny/scena 3.tscn")
		0:
			Fade.fade_out("res://sceny/letsgo.tscn")
