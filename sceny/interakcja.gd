extends Node3D

@onready var dialogi = $Dialogi

func interact(_player_position):
	return dialogi.get_node("Default").dialog
