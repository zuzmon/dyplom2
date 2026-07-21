extends Node3D

@onready var dialogi = $Dialogi

func interact(_player_position):
	if Global.teddy_steal:
		Global.teddy_steal = false
		Global.kobieta_default_first_printer = false
		Global.kobieta_after_first_printer = true
		return dialogi.get_node("Steal").dialog
	return dialogi.get_node("Default").dialog
