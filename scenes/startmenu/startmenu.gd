extends Node

func _ready() -> void:
	var escape_menu = load('res://scenes/escapemenu/escapemenu.tscn').instantiate()
	self.add_child(escape_menu)
	
	escape_menu.button1.text = 'Play'
	escape_menu.button2.text = 'Controls'

	escape_menu.can_toggle_via_keybind = false

	escape_menu.button1_pressed.connect(_on_play_pressed)
	escape_menu.button2_pressed.connect(_on_credits_pressed)

## Signal Connections
func _on_play_pressed() -> void:
	SceneLoader.load_level('game')

func _on_credits_pressed() -> void:
	SceneLoader.load_level('controls')

func _on_quit_pressed() -> void:
	get_tree().quit()