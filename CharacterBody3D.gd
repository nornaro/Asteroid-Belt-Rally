extends CharacterBody3D

var speed = 0
const SPEED = [0, 100]
var thrust_accel = 10 # acceleration rate for the thrust
const THRUST_SPEED = 20 # Max speed due to thrusters
var boost = 1

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$Light3D1.light_color = Color.CYAN
	$Light3D2.light_color = Color.CYAN

func _input(event):
	var step = 1
	boost = 1
	if Input.is_action_just_pressed("EmergStop"):
		speed = 0
	if Input.is_action_pressed("Boost"):
		speed = 100
		boost = 2
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_WHEEL_UP):
		speed = clamp(SPEED[0], speed + 1, SPEED[1])
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_WHEEL_DOWN):
		speed = clamp(SPEED[0], speed - 1, SPEED[1])	
	$Light3D1.light_energy = 0.16*speed
	$Light3D2.light_energy = 0.16*speed
	print(speed)
		
	var dynamic_turn_ratio = map_value(speed, SPEED[0], SPEED[1], 0.02, 0.1)  # Adjust these numbers to your needs

	if event is InputEventMouseMotion:
		if speed > 0:
			var mouse_delta = event.relative
			var rotation_delta = Vector3(mouse_delta.y, -mouse_delta.x, 0).normalized()
			rotate_object_local(rotation_delta, dynamic_turn_ratio)
	
func _physics_process(delta):
	var input_dir = Input.get_vector("ThrusterL", "ThrusterR", "ThrusterU", "ThrusterD")
	var direction = (transform.basis * Vector3(input_dir.x, input_dir.y, 1)).normalized()
	thrust(direction, delta)
	velocity.z = move_toward(velocity.z, transform.basis.z.z * speed, thrust_accel * delta) * boost
	
	move_and_slide()

func thrust(direction, delta):
	if direction.length() != 0:
		velocity.x = move_toward(velocity.x, direction.x * THRUST_SPEED, thrust_accel * delta)
		velocity.y = move_toward(velocity.y, direction.y * THRUST_SPEED, thrust_accel * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, thrust_accel * delta)
		velocity.y = move_toward(velocity.y, 0, thrust_accel * delta)

func map_value(value, in_min, in_max, out_min, out_max):
	return (value - in_min) / (in_max - in_min) * (out_max - out_min) + out_min
