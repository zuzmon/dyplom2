extends Node

var kolega_game_start := true
var kobieta_first_printer := true
var kobieta_default_first_printer := true
var teddy_steal := false
var kobieta_after_first_printer := false
var boss_first_papers := false
var work_first_email := false
var kobieta_ask := false
var boss_ask := false
var work_second_email := false
var kobieta_second_printer := false
var boss_second_papers := false
var kolega_teddy := false
var over := false

var player_teleport_pos
var player_teleport_rot
var head_teleport_rot
var cam_teleport_rot

func reset():
	kolega_game_start = true
	kobieta_first_printer = true
	kobieta_default_first_printer = true
	teddy_steal = false
	kobieta_after_first_printer = false
	boss_first_papers = false
	work_first_email = false
	kobieta_ask = false
	boss_ask = false
	work_second_email = false
	kobieta_second_printer = false
	boss_second_papers = false
	kolega_teddy = false
	over = false
