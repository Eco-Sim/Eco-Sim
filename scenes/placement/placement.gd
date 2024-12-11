class_name Placement extends Node2D

@export var procedural_generation: ProceduralGeneration
@export var camera_controller: CameraController

@onready var atlas := load("res://assets/tilesets/structures.png") as Texture2D

func _input(event: InputEvent) -> void:
	if !(event is InputEventMouseButton):
		return

	if !event.is_action_pressed('interact'):
		return
	
	var cell_position := GridUtil.get_cell_position(camera_controller.get_global_mouse_position())

	print('Click Position: ', camera_controller.get_global_mouse_position(), ' - Placed Position: ', GridUtil.get_world_position(cell_position.x, cell_position.y))

	var formatted_node_name := '{x} {y}'.format({ 'x':  cell_position.x, 'y': cell_position.y})
	if !procedural_generation.has_node(formatted_node_name):
		print('invalid placement position! ', cell_position, ' - ', camera_controller.get_global_mouse_position())
		return
	
	if self.has_node(formatted_node_name):
		print('structure already exists at position!')
		return

	var sprite := Sprite2D.new()
	self.add_child(sprite)
	
	sprite.name = formatted_node_name

	var atlas_texture := AtlasTexture.new()
	atlas_texture.region = Rect2i(Vector2i(32, 48) * 0, Vector2i(32, 48))
	atlas_texture.atlas = atlas

	sprite.texture = atlas_texture
	sprite.position = GridUtil.get_world_position(cell_position.x, cell_position.y)