extends Control

func _on_play_button_pressed():
	Fade.fade_out("res://sceny/letsgo.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
