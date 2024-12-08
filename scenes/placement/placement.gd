class_name Placement extends Node2D

@onready var tile_map := $TileMap as TileMapLayer

var terrain_tile_map: TileMapLayer

func _unhandled_input(event):
	if !is_instance_valid(terrain_tile_map):
		return

	if !(event is InputEventMouseButton):
		return

	if !event.is_action_pressed('interact'):
		return

	var clicked_cell := terrain_tile_map.local_to_map(terrain_tile_map.get_local_mouse_position())
	var atlas_coords = terrain_tile_map.get_cell_atlas_coords(clicked_cell)
	
	if atlas_coords == Vector2i(-1,-1):
		return