extends Node3D
signal over

@onready var dialogi = $Dialogi

func interact(_player_position):
	emit_signal("over")
	return dialogi.get_node("Default").dialog
