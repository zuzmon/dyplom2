extends CharacterBody3D

var speed
const WALK_SPEED = 5.0
const SPRINT_SPEED = 9.0
const JUMP_VELOCITY = 5.5
const SENSITIVITY = 0.002
const GRAVITY = 2.0

const BOB_FREQ = 2.0
const BOB_AMP = 0.08
var t_bob = 0.0

const BASE_FOV = 75.0
const FOV_CHANGE = 1.5

@onready var head = $Head
@onready var camera = $Head/Camera3D
@onready var raycast = $Head/Camera3D/RayCast3D
@onready var dialog_text = $CanvasLayer/Control/Panel/Label

var talking := false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$CanvasLayer/Control/Panel.hide()

func _unhandled_input(event):
	if talking:
		return
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(70))

func start_dialog(object):
	talking = true
	$CanvasLayer/Control/Panel.show()
	camera.look_at(object.position)
	camera.rotation.y = 0
	camera.rotation.z = 0
	var tween = get_tree().create_tween()
	tween.tween_property(camera, "fov", 50.0, 0.2)

# Przechowywanie aktualnej linii dialogu i indeksu litery
var current_line_index = 0
var current_char_index = 0
var is_text_scrolling = false
var full_line = ""
var typing_speed = 0.05  # Czas (w sekundach) między literami
var typing_active = false  # Flaga kontrolująca, czy animacja jest aktywna
var dialog = null

func _process(_delta):
	# Sprawdzenie kliknięcia w trakcie wyświetlania tekstu
	if not talking:
		return
	if Input.is_action_just_pressed("skip"):
		if is_text_scrolling:
			# Jeśli tekst jest w trakcie przewijania, wyświetl go od razu
			skip_text_animation()
		else:
			# Jeśli tekst został w pełni wyświetlony, przejdź do następnej linii
			show_next_line()

# Funkcja do wyświetlenia kolejnej linii dialogu
func show_next_line():
	if current_line_index < dialog.size():
		full_line = dialog[current_line_index]
		#if full_line[0] == "?":
			#animation_player.play("ghost_talk")
		#elif full_line[0] == "!":
			#animation_player.play("burgmaster_talk")
		#full_line[0] = ""
		current_char_index = 0
		dialog_text.text = ""
		is_text_scrolling = true
		typing_active = true
		# Rozpoczynamy animację liter
		start_typing_text()

	else:
		if Global.over:
			Global.over = false
			get_tree().change_scene_to_file("res://sceny/scena 1.tscn")
			return
		$CanvasLayer/Control/Panel.hide()
		var tween = get_tree().create_tween()
		tween.tween_property(camera, "fov", BASE_FOV, 0.2)
		talking = false
		current_line_index = 0
		current_char_index = 0
		dialog = null
		#get_parent().get_parent().after_dialog()
		#animation_player.play("popout")
		#queue_free()
		# Koniec dialogu, np. zamknij scenę dialogu
		#print("Koniec dialogów.")

# Funkcja stopniowo wyświetlająca tekst
func start_typing_text():
	# Wywołuje się co "typing_speed" sekund, aż wyświetli cały tekst
	if typing_active:
		await get_tree().create_timer(typing_speed).timeout
		if current_char_index < full_line.length() and typing_active:
			dialog_text.text += full_line[current_char_index]
			current_char_index += 1
			# Kontynuujemy wyświetlanie liter, jeśli jeszcze nie skończono
			start_typing_text()
		else:
			# Cała linia została wyświetlona
			is_text_scrolling = false
			typing_active = false
			#display_label.text = full_line
			current_line_index += 1

# Funkcja natychmiastowego wyświetlenia całego tekstu
func skip_text_animation():
	is_text_scrolling = false
	typing_active = false  # Przerywamy dalsze animowanie liter
	dialog_text.text = full_line

	# Zwiększ indeks dialogu na następny
	#current_line_index += 1

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * GRAVITY
	
	if talking:
		return
	
	if Input.is_action_just_pressed("interact"):
		if raycast.is_colliding():
			var body = raycast.get_collider()
			if body.is_in_group("interactable"):
				body.get_parent().interact()
				print("int")
			elif body.is_in_group("talking"):
				dialog = body.get_parent().interact(self.global_position)
				start_dialog(body)

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_pressed("sprint"):
		speed = SPRINT_SPEED
	else:
		speed = WALK_SPEED

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 7.0)
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 7.0)
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 3.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 3.0)
		
		
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(t_bob)
	
	var velocity_clamped = clamp(velocity.length(), 0.5, SPRINT_SPEED * 2)
	var target_fov = BASE_FOV + FOV_CHANGE * velocity_clamped
	camera.fov = lerp(camera.fov, target_fov, delta * 8.0)

	move_and_slide()
	
func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP 
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos
