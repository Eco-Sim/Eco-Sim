class_name ProceduralGeneration extends Node2D

@export var noise_heightmap: NoiseTexture2D
@export var width: int:
	get:
		return noise_heightmap.width
	set(value):
		noise_heightmap.width = value
@export var height: int: 
	get:
		return noise_heightmap.height
	set(value): 
		noise_heightmap.height = value

@onready var tile_map := $TileMap as TileMapLayer

const TILE_MAP_SOURCE_ID = 3
const TILE_ATLASES := [
	{ # Water
		100: Vector2i(6, 0)
	},
	{ # Sand
		90: Vector2i(0, 3),
		10: Vector2i(1, 3),
	},
	{ # grasslands
		70: Vector2i(0, 0),
		30: Vector2i(1, 0)
	},
	{ # dense trees
		100: Vector2i(2, 0)
	},
	{ # Mountains
		90: Vector2i(5, 0),
		10: Vector2i(4, 0)
	}
]

func weighted_choice(seq: Array, weights: Array):
	var cum_weights = [0]
	var tot = 0
	assert(seq.size() == weights.size())
	for w in weights:
		tot += w
		cum_weights.append(tot)

	# weighted indexing with a random val
	var val = randf_range(0, tot)
	return seq[cum_weights.bsearch(val) - 1]

func determine_tile_set_index_from_noise(value: float) -> int:
	var color_ramp := noise_heightmap.color_ramp

	if value < color_ramp.get_offset(1):
		return 0
	elif value < color_ramp.get_offset(2):
		return 1
	elif value < color_ramp.get_offset(3):
		return 2
	elif value < color_ramp.get_offset(4):
		return 3
	else:
		return 4

# Meant to be called by the parent node
func generate_world():
	for x in range(width):
		for y in range(height):
			var noise_value := noise_heightmap.noise.get_noise_2d(x, y)

			var index := determine_tile_set_index_from_noise(noise_value)
			var atlas_set: Dictionary = TILE_ATLASES[index]
			 
			var q := x
			var r := y - (height / 2.0) as int

			tile_map.set_cell(Vector2i(q, r), TILE_MAP_SOURCE_ID, weighted_choice(atlas_set.values(), atlas_set.keys()))
	print('Generation Finished')