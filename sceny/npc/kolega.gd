extends Node3D

@onready var dialogi = $Dialogi

func _ready():
	$AnimatedSprite3D.hide()

func interact(player_position):
	self.look_at(player_position, Vector3(0,1,0), true)
	
	if Global.kolega_game_start:
		Global.kolega_game_start = false
		return dialogi.get_node("GameStart").dialog
	if Global.kolega_teddy:
		$AnimatedSprite3D.show()
		Global.kolega_teddy = false
		Global.over = true
		return dialogi.get_node("Teddy").dialog
	return dialogi.get_node("Default").dialog
