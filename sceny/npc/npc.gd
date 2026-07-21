extends Node3D

@onready var dialogi = $Dialogi

func interact(player_position):
	self.look_at(player_position, Vector3(0,1,0), true)
	return dialogi.get_node("Default").dialog
