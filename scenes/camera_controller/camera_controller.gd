# Camera Controller Script
# https://gitlab.com/realrobots/rimworldripoff/-/blob/1ee8ef79c7ac03e56628dbece33f855c2e090523/CameraController.gd

class_name CameraController extends Camera2D

@export var zoom_speed : float = 10.0;
@export var pan_speed: float = 1.0;

@export var max_zoom: float = 1
@export var min_zoom: float = 0.5

var zoom_target :Vector2

var drag_start_mouse_pos = Vector2.ZERO
var drag_start_camera_pos = Vector2.ZERO
var is_dragging : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	zoom_target = zoom
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_tree().paused:
		return
	
	simple_pan(delta)
	click_and_drag()
	_zoom(delta)
	
func _zoom(delta):
	if Input.is_action_just_pressed("camera_zoom_in"):
		zoom_target *= 1.1
		
	if Input.is_action_just_pressed("camera_zoom_out"):
		zoom_target *= 0.9

	zoom_target = Vector2(min(max(zoom_target.x, min_zoom), max_zoom), min(max(zoom_target.y, min_zoom), max_zoom))

	zoom = zoom.slerp(zoom_target, zoom_speed * delta)
	
func simple_pan(delta):
	var moveAmount = Vector2.ZERO
	if Input.is_action_pressed("camera_move_right"): moveAmount.x += 1
	if Input.is_action_pressed("camera_move_left"): moveAmount.x -= 1
	if Input.is_action_pressed("camera_move_up"): moveAmount.y -= 1
	if Input.is_action_pressed("camera_move_down"): moveAmount.y += 1
		
	moveAmount = moveAmount.normalized()
	position += moveAmount * delta * 1000 * (1/zoom.x) * pan_speed

func click_and_drag():
	if !is_dragging and Input.is_action_just_pressed("camera_pan"):
		drag_start_mouse_pos = get_viewport().get_mouse_position()
		drag_start_camera_pos = position
		is_dragging = true
		
	if is_dragging and Input.is_action_just_released("camera_pan"):
		is_dragging = false
		
	if is_dragging:
		var moveVector = get_viewport().get_mouse_position() - drag_start_mouse_pos
		position = drag_start_camera_pos - moveVector * 1/zoom.x