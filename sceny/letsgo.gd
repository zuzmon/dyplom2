extends Node3D

var kobieta_ask_flag := false
var teddy_steal_flag := false

func _ready():
	$NPC_Kobieta.global_position = Vector3(36.8, -0.1, 45.5)
	$NPC_Kobieta.rotation = Vector3(0.0, -90.0, 0.0)
	$"NPC_Kobieta/baba idzie".hide()
	$"NPC_Kobieta/baba stoi".show()
	$CanvasLayer/Control/Kursor.hide()
	$CanvasMenu.show()

func _on_start_button_pressed():
	$AnimationPlayer.play("start_game")
	$CanvasMenu.hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_start_end():
	$CanvasLayer/Control/Kursor.show()
	$player.menu = false

func _on_quit_button_pressed():
	get_tree().quit()

func _on_nasze_biurko_first_email():
	$NPC_Kobieta.global_position = Vector3(-3.7, -0.1, -3.7)
	$NPC_Kobieta.rotation = Vector3(0.0, 88.6, 0.0)

func _on_npc_kobieta_ask():
	kobieta_ask_flag = true

func _on_npc_boss_ask():
	$AnimationPlayer.stop()
	$NPC_Kobieta.global_position = Vector3(36.8, -0.1, 45.5)
	$NPC_Kobieta.rotation = Vector3(0.0, -90.0, 0.0)
	$"NPC_Kobieta/baba idzie".hide()
	$"NPC_Kobieta/baba stoi".show()

func _on_player_dialog_over():
	if kobieta_ask_flag:
		kobieta_ask_flag = false
		$AnimationPlayer.play("baba_pojdzie")
	if teddy_steal_flag:
		teddy_steal_flag = false
		$czerwony.hide()

func _on_czerwony_teddy_steal():
	teddy_steal_flag = true
