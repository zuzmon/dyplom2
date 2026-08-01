extends Node3D

var over_flag := false

func _on_final_teddy_over():
	over_flag = true

func _on_player_dialog_over():
	if over_flag:
		get_tree().quit()
