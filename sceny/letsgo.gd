extends Node3D

var kobieta_ask_flag := false
var teddy_steal_flag := false
var kobieta_print_flag := false
var begin_dialog := ["cHey man, are you okay?", "jHuh? Oh... yeah.",
"cOkay. In that case, here are the files. Print these documents and take them to the boss."]

var first_turn_flag := false
var second_turn_flag := false
var flag_count := 0

func _ready():
	if Global.ending:
		$czerwony2.show()
	else:
		$czerwony2.hide()
	$NPC_Kobieta.global_position = Vector3(34.345, -0.1, 47.2)
	$NPC_Kobieta.rotation = Vector3(0.0, -90.0, 0.0)
	$"NPC_Kobieta/baba idzie".hide()
	$"NPC_Kobieta/baba grzebie".hide()
	$"NPC_Kobieta/baba stoi".show()
	$player/CanvasLayer/Control/Kursor.hide()
	$CanvasMenu.show()
	$"player/Head/Camera3D/papier do ręki".hide()
	$player/CanvasLayer/Control/TextureRect.hide()

func begin():
	$player.dialog = begin_dialog
	$player.start_dialog(null)
	first_turn_flag = true

func _on_start_button_pressed():
	$Click.play()
	$AnimationPlayer.play("start_game")
	$CanvasMenu.hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$player/CanvasLayer/Control/TextureRect.show()

func _on_start_end():
	$player/CanvasLayer/Control/Kursor.show()
	$player.menu = false
	call_deferred("begin")
	#begin()

func _on_quit_button_pressed():
	$Click.play()
	await $Click.finished
	get_tree().quit()

func _on_nasze_biurko_first_email():
	$NPC_Kobieta.global_position = Vector3(-3.7, -0.1, -3.7)
	$NPC_Kobieta.rotation = Vector3(0.0, 88.6, 0.0)
	$drzwi.close()

func _on_npc_kobieta_ask():
	kobieta_ask_flag = true

func _on_npc_boss_ask():
	Global.kolega_game_start = false
	$NPC_Kobieta/StaticBody3D/CollisionShape3D.set_deferred("disabled", false)
	$AnimationPlayer.stop()
	$NPC_Kobieta.global_position = Vector3(36.8, -0.1, 45.5)
	$NPC_Kobieta.rotation = Vector3(0.0, -90.0, 0.0)
	$"NPC_Kobieta/baba idzie".hide()
	$"NPC_Kobieta/baba stoi".show()

func _on_player_dialog_over():
	$player/Head/Camera3D.current = true
	if Global.ending:
		Fade.fade_out("res://sceny/ending.tscn")
	if kobieta_ask_flag:
		kobieta_ask_flag = false
		$AnimationPlayer.play("baba_pojdzie")
	if teddy_steal_flag:
		teddy_steal_flag = false
		$czerwony.hide()
	if kobieta_print_flag:
		kobieta_print_flag = false
		$NPC_Kobieta.printer()

func _on_czerwony_teddy_steal():
	teddy_steal_flag = true
	$NPC_Kobieta.printing = false
	$"NPC_Kobieta/baba grzebie".hide()
	$"NPC_Kobieta/baba stoi".show()
	$NPC_Kobieta.rotation.y = -90.0

func _on_npc_boss_give_paper():
	$"player/Head/Camera3D/papier do ręki".hide()
	if $player/CanvasLayer/Control/Winieta2.visible:
		$player/CanvasLayer/Control/Winieta3.show()
		$player/AnimationPlayer.play("winieta3")
	else:
		$player/CanvasLayer/Control/Winieta2.show()
		$player/AnimationPlayer.play("winieta2")

func _on_npc_kobieta_paper():
	$"player/Head/Camera3D/papier do ręki".show()

func _on_line_edit_editing_toggled(toggled_on):
	if toggled_on:
		$Click.play()

func _on_npc_kobieta_on_printer():
	kobieta_print_flag = true

func _on_nasze_biurko_second_email():
	second_turn_flag = true

func _on_player_next_line():
	if first_turn_flag:
		first_turn_flag = false
		$Camera3D.current = true
		$NPC_Kolega.rotation_degrees = Vector3(0, 92.3, 0)
	if second_turn_flag:
		flag_count += 1
		if flag_count == 7:
			second_turn_flag = false
			$Camera3D.current = true
			$NPC_Kolega.rotation_degrees = Vector3(0, 92.3, 0)
