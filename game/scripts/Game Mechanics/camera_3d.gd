extends Camera3D

@export var min_zoom: float = 0.3
@export var max_zoom: float = 3.5
@export var zoom_speed: float = 1.1
@export var min_tilt_angle: float = 45.0
@export var max_tilt_angle: float = 90.0
@export var pan_speed: float = 1.0
@export var edge_threshold: float = 60.0

var target_position: Vector3 = Vector3.ZERO
var current_zoom: float = (min_zoom + max_zoom) / 2

func _ready():
	update_camera_position()

func _process(delta):
	handle_pan(delta)
	update_camera_position()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom_camera(1/zoom_speed)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom_camera(zoom_speed)

func calculate_zoom_out(zoom_amount):
	return clamp(current_zoom * zoom_amount, min_zoom, max_zoom)

func zoom_camera(zoom_amount):
	if calculate_zoom_out(zoom_amount) != max_zoom:
		current_zoom = calculate_zoom_out(zoom_amount)

func handle_pan(delta):
	var viewport_size = get_viewport().size
	var mouse_position = get_viewport().get_mouse_position()
	
	var pan_direction = Vector3.ZERO
	
	if mouse_position.x < edge_threshold:
		pan_direction.x -= 1
	elif mouse_position.x > viewport_size.x - edge_threshold:
		pan_direction.x += 1
	
	if mouse_position.y < edge_threshold:
		pan_direction.z -= 1
	elif mouse_position.y > viewport_size.y - edge_threshold:
		pan_direction.z += 1
	
	target_position += pan_direction.normalized() * pan_speed * current_zoom * delta

func update_camera_position():
	var zoom_factor = (current_zoom - min_zoom) / (max_zoom - min_zoom)
	var height = current_zoom * sin(deg_to_rad(lerp(min_tilt_angle, max_tilt_angle, zoom_factor)))
	var distance = current_zoom * cos(deg_to_rad(lerp(min_tilt_angle, max_tilt_angle, zoom_factor)))
	
	var new_position = target_position + Vector3(0, height, distance)
	set_position(new_position)
	
	look_at(target_position, Vector3.UP)
