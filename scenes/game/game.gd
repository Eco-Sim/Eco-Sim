extends Control

func _ready() -> void:
	print('LOADED GAME')
	var escape_menu: EscapeMenu = load('res://scenes/escapemenu/escapemenu.tscn').instantiate()
	self.add_child(escape_menu)

	escape_menu.button1.text = 'Continue'
	escape_menu.button2.text = 'Return'

	escape_menu.button1_pressed.connect(_on_continue_pressed)
	escape_menu.button2_pressed.connect(_on_return_pressed)
	
	escape_menu.visible = false

func _on_continue_pressed():
	pass

func _on_return_pressed():
	SceneLoader.load_level('startmenu')
