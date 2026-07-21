extends Node3D

@onready var dialogi = $Dialogi

func interact(player_position):
	self.look_at(player_position, Vector3(0,1,0), true)
	
	if Global.kobieta_first_printer:
		Global.kobieta_first_printer = false
		Global.teddy_steal = true
		return dialogi.get_node("FirstPrinter").dialog
	if Global.kobieta_default_first_printer:
		return dialogi.get_node("DefaultFirstPrinter").dialog
	if Global.kobieta_after_first_printer:
		Global.kobieta_after_first_printer = false
		Global.boss_first_papers = true
		return dialogi.get_node("AfterFirstPrinter").dialog
	if Global.kobieta_ask:
		Global.kobieta_ask = false
		Global.boss_ask = true
		return dialogi.get_node("Ask").dialog
	if Global.kobieta_second_printer:
		Global.kobieta_second_printer = false
		Global.boss_second_papers = true
		return dialogi.get_node("SecondPrinter").dialog
	return dialogi.get_node("Default").dialog
