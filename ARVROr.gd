extends ARVROrigin

# Referencia al joystick virtual
onready var joystick = get_node("../Virtual_joystick")
onready var player_camera = $Player_Camera
onready var left_controller = $Left_Controller
onready var right_controller = $Right_Controller

var input_vector


const MOVEMENT_SPEED = 1.5

func _process(delta):
	input_vector = joystick.get_output()

	if input_vector.length() > 0:
		move_player(input_vector, delta)

func move_player(direction, delta):
	var forward_direction = player_camera.global_transform.basis.z.normalized()
	var right_direction = player_camera.global_transform.basis.x.normalized()

	var movement_vector = Vector2(direction.x, direction.y).normalized()
	var movement_forward = forward_direction * movement_vector.x * delta * MOVEMENT_SPEED
	var movement_right = right_direction * movement_vector.y * delta * MOVEMENT_SPEED

	movement_forward.y = 0
	movement_right.y = 0

	if movement_right.length() > 0 or movement_forward.length() > 0:
		translate(movement_right + movement_forward)
