extends Node2D

@onready var procedural_generation := $ProceduralGeneration as ProceduralGeneration
@onready var escape_menu := $EscapeMenu as EscapeMenu
@onready var placement := $Placement as Placement

func _ready() -> void:
	# # Setup Escape Menu
	escape_menu.button1_pressed.connect(_on_continue_pressed)
	escape_menu.button2_pressed.connect(_on_return_pressed)

	# Setup Procedural Generation
	(procedural_generation.noise_heightmap.noise as FastNoiseLite).seed = randi()

	var size := 100
	procedural_generation.width = size
	procedural_generation.height = size * 7

	procedural_generation.generate_world()

func _on_continue_pressed():
	escape_menu.visible = false

func _on_return_pressed():
	SceneLoader.load_level('startmenu')