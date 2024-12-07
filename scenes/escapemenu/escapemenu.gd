class_name EscapeMenu extends Control

@onready var quit := $Quit as Button
@onready var button1 := $Button1 as Button
@onready var button2 := $Button2 as Button
@onready var blur := $Blur as Panel
@onready var audio_stream_player := $AudioStreamPlayer2D as AudioStreamPlayer2D

@export var click_sound := preload("res://assets/audio/click.ogg")

signal is_quit_button_visible_changed(is_visible: bool)
@export var is_quit_button_visible: bool:
	get:
		return quit.visible
	set(value):
		quit.visible = is_quit_button_visible == true
		is_quit_button_visible_changed.emit(value)

signal button1_text_changed(is_visible: bool)
@export var button1_text: String = 'Button 1':
	get:
		return button1.text
	set(value):
		button1.text = value
		button1_text_changed.emit(value)

signal button2_text_changed(is_visible: bool)
@export var button2_text: String = 'Button 2':
	get:
		return button2.text
	set(value):
		button2.text = value
		button2_text_changed.emit(value)
	
signal can_toggle_via_keybind_changed(can_toggle: bool)
@export var can_toggle_via_keybind: bool = true:
	set(value):
		can_toggle_via_keybind = value
		can_toggle_via_keybind_changed.emit(value)

signal button1_pressed
func _on_button1_pressed() -> void:
	ClickSoundUtil.play(self)
	button1_pressed.emit()

signal button2_pressed
func _on_button2_pressed() -> void:
	ClickSoundUtil.play(self)
	button2_pressed.emit()

func _on_quit_pressed() -> void:
	if (!is_quit_button_visible):
		return
	ClickSoundUtil.play(self)
	get_tree().quit()

func _unhandled_input(event: InputEvent) -> void:
	if (!event.is_action_released('Escape_Menu')):
		return
	
	if (!can_toggle_via_keybind):
		return
	
	self.visible = !self.visible

	ClickSoundUtil.play(self)
	
	print('ESCAPE MENU BUTTON PRESSED!!!!')