extends Node3D

@onready var dialogi = $Dialogi

func interact():
	return dialogi.get_node("Default").dialog
