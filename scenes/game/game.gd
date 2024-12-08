extends Node2D

func _ready() -> void:
	# Setup Escape Menu
	var escape_menu: EscapeMenu = load('res://scenes/escapemenu/escapemenu.tscn').instantiate()
	self.add_child(escape_menu)

	escape_menu.button1.text = 'Continue'
	escape_menu.button2.text = 'Return'

	escape_menu.button1_pressed.connect(_on_continue_pressed)
	escape_menu.button2_pressed.connect(_on_return_pressed)
	
	escape_menu.visible = false

	# Setup Procedural Generation
	var procedural_generation: ProceduralGeneration = load("res://scenes/procedural_generation/procedural_generation.tscn").instantiate()
	self.add_child(procedural_generation)

	(procedural_generation.noise_heightmap.noise as FastNoiseLite).seed = randi()
	
	procedural_generation.generate_world()

	print('LOADED GAME')

func _on_continue_pressed():
	pass

func _on_return_pressed():
	SceneLoader.load_level('startmenu')