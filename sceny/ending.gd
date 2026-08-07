extends Control


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_retry_button_pressed():
	$Click.play()
	Fade.fade_out("res://sceny/letsgo.tscn")

func _on_quit_button_pressed():
	$Click.play()
	Fade.fade_quit()
