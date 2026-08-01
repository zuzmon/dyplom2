extends Node3D

@export var openable := true
var opened := false
var open_degrees
var close_degrees

func _ready():
	close_degrees = rotation_degrees.y
	open_degrees = close_degrees + 90.0

func interact():
	if openable:
		if opened:
			rotation_degrees.y = close_degrees
			opened = false
		else:
			rotation_degrees.y = open_degrees
			opened = true
	else:
		pass

func close():
	opened = false
	rotation_degrees.y = close_degrees
