extends Node3D
signal ask
signal paper
signal on_printer

@onready var dialogi = $Dialogi

var printing := false

func _ready():
	$AnimatedSprite3D.hide()

func printer():
	printing = true
	$"baba stoi".hide()
	$"baba grzebie".show()
	$"baba grzebie/AnimationPlayer".play("mixamo_com")
	self.rotation.y = 0.0

func interact(player_position):
	if not printing:
		self.look_at(player_position, Vector3(0,1,0), true)
	
	if Global.kobieta_first_printer:
		emit_signal("on_printer")
		Global.kobieta_first_printer = false
		Global.teddy_steal = true
		return dialogi.get_node("FirstPrinter").dialog
	if Global.kobieta_default_first_printer:
		return dialogi.get_node("DefaultFirstPrinter").dialog
	if Global.kobieta_after_first_printer:
		emit_signal("paper")
		Global.kobieta_after_first_printer = false
		Global.boss_first_papers = true
		return dialogi.get_node("AfterFirstPrinter").dialog
	if Global.kobieta_ask:
		emit_signal("ask")
		Global.kobieta_ask = false
		Global.boss_ask = true
		return dialogi.get_node("Ask").dialog
	if Global.kobieta_second_printer:
		emit_signal("paper")
		$AnimatedSprite3D.show()
		Global.kobieta_second_printer = false
		Global.boss_second_papers = true
		return dialogi.get_node("SecondPrinter").dialog
	return dialogi.get_node("Default").dialog
