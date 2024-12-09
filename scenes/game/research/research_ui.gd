## Handles rendering research updates to the UI
class_name ResearchUI extends CanvasLayer

@onready var disruptive_viewport := $Inner/DisruptiveViewportContainer as SubViewportContainer
@onready var harmonic_viewport := $Inner/HarmonicViewportContainer as SubViewportContainer
@onready var vignette := $Inner/Background/Vignette as Panel
@onready var return_button := $Inner/Return as Button

@onready var active_sub_viewport := $Inner/HarmonicViewportContainer/SubViewport as SubViewport

var drag_start_mouse_pos = Vector2.ZERO
var drag_start_camera_pos = Vector2.ZERO
var is_dragging : bool = false

func _ready() -> void:
	_on_harmonic_pressed()

func _on_return_pressed() -> void:
	self.visible = false

func set_vignette_color(hex: String) -> void:
	var material := vignette.material as ShaderMaterial
	material.set_shader_parameter('color', Color.from_string(hex, hex))

func reset_active_sub_viewport_position():
	active_sub_viewport.get_parent().position = Vector2(-50, -35)
	
func _on_disruptive_pressed() -> void:
	disruptive_viewport.visible = true
	harmonic_viewport.visible = false

	reset_active_sub_viewport_position()

	active_sub_viewport = disruptive_viewport.get_node('SubViewport')
	set_vignette_color('#ff4040')

func _on_harmonic_pressed() -> void:
	harmonic_viewport.visible = true
	disruptive_viewport.visible = false

	reset_active_sub_viewport_position()

	active_sub_viewport = harmonic_viewport.get_node('SubViewport')
	set_vignette_color('#55ff85')

func _process(_delta: float) -> void:
	if !visible:
		return

	click_and_drag()

func click_and_drag():
	if !is_dragging and Input.is_action_just_pressed("camera_pan"):
		drag_start_mouse_pos = get_viewport().get_mouse_position()
		drag_start_camera_pos = active_sub_viewport.get_parent().position
		is_dragging = true
		
	if is_dragging and Input.is_action_just_released("camera_pan"):
		is_dragging = false
		
	if is_dragging:
		var moveVector = get_viewport().get_mouse_position() - drag_start_mouse_pos
		active_sub_viewport.get_parent().position = drag_start_camera_pos + moveVector