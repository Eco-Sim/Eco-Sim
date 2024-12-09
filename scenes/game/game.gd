extends Node2D

var escape_menu: EscapeMenu

func _ready() -> void:
	# Setup Escape Menu
	escape_menu = load('res://scenes/escapemenu/escapemenu.tscn').instantiate()
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

	var size := 100
	procedural_generation.width = size
	procedural_generation.height = size * 7

	procedural_generation.generate_world()

	# Setup Placement
	var placement: Placement = load("res://scenes/placement/placement.tscn").instantiate()
	self.add_child(placement)
	
	placement.terrain_tile_map = procedural_generation.tile_map

func _on_continue_pressed():
	escape_menu.visible = false

func _on_return_pressed():
	SceneLoader.load_level('startmenu')