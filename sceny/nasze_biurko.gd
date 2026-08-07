extends Node3D
signal first_email
signal second_email

@onready var dialogi = $Dialogi

func interact(_player_position):
	if Global.work_first_email:
		emit_signal("first_email")
		Global.work_first_email = false
		Global.kobieta_ask = true
		return dialogi.get_node("WorkFirstEmail").dialog
	if Global.work_second_email:
		emit_signal("second_email")
		Global.work_second_email = false
		Global.kobieta_second_printer = true
		return dialogi.get_node("WorkSecondEmail").dialog
	return dialogi.get_node("Default").dialog
