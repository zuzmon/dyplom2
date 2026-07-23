extends Node3D
signal ask

@onready var dialogi = $Dialogi

func _ready():
	$AnimatedSprite3D.hide()

func interact(player_position):
	self.look_at(player_position, Vector3(0,1,0), true)
	
	if Global.boss_first_papers:
		Global.boss_first_papers = false
		Global.work_first_email = true
		return dialogi.get_node("FirstPapers").dialog
	if Global.boss_ask:
		emit_signal("ask")
		$AnimatedSprite3D.show()
		Global.boss_ask = false
		Global.work_second_email = true
		return dialogi.get_node("Ask").dialog
	if Global.boss_second_papers:
		Global.boss_second_papers = false
		Global.kolega_teddy = true
		return dialogi.get_node("SecondPapers").dialog
	return dialogi.get_node("Default").dialog
