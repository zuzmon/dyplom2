extends Node3D
signal teleport

#@export var scene := 1

func interact():
	emit_signal("teleport")
