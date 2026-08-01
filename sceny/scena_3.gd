extends Node3D

var over_flag := false
var begin_dialog := ["tCome to me"]

func _ready():
	$player.dialog = begin_dialog
	$player.start_dialog($FinalTeddy)

func _on_final_teddy_over():
	over_flag = true

func _on_player_dialog_over():
	if over_flag:
		Fade.fade_out("res://sceny/letsgo.tscn")
