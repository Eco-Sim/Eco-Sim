class_name ProceduralGeneration extends Node2D

@export var noise_heightmap: NoiseTexture2D
@onready var width: int:
	get:
		return noise_heightmap.width
	set(value):
		noise_heightmap.width = value
@onready var height: int: 
	get:
		return noise_heightmap.height
	set(value): 
		noise_heightmap.height = value

@onready var tile_map := $TileMap as TileMapLayer

@onready var atlas := load("res://assets/tilesets/hextiles.png") as Texture2D

const GRID_CORNER_MULTIPLIER = 3

const TILE_MAP_SOURCE_ID = 3
const TILE_ATLASES := [
	[ ## Normal grassy w beaches
		{ # Water
			100: Vector2i(6, 0)
		},
		{ # Beach
			90: Vector2i(0, 3),
			10: Vector2i(1, 3),
		},
		{ # Main Terrain
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
	],
	[ ## Snowy
		{ # Water
			90: Vector2i(6, 0),
			10: Vector2i(5, 2)
		},
		{ # Beach
			100: Vector2i(0, 2),
		},
		{ # Main Terrain
			90: Vector2i(0, 2),
			10: Vector2i(1, 2)
		},
		{ # dense trees
			100: Vector2i(2, 2)
		},
		{ # Mountains
			90: Vector2i(4, 2),
			10: Vector2i(3, 2)
		}
	],
	[ ## Desert
		{ # Water
			100: Vector2i(6, 0)
		},
		{ # Beach
			99: Vector2i(0, 3),
			1: Vector2i(5, 3),
		},
		{ # Main Terrain
			96: Vector2i(0, 3),
			3: Vector2i(1, 3),
			1: Vector2i(3, 3),
		},
		{ # dense trees
			100: Vector2i(2, 3)
		},
		{ # Mountains
			90: Vector2i(3, 3),
			10: Vector2i(1, 3)
		}
	],
]

func weighted_choice(seq: Array, weights: Array) -> Vector2i:
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

func in_map(x: int,y: int) -> bool:
	var r = ceil(height / 2)
	var cube = oddq_to_cube(Vector2(x, y))

	return cube.x <= r and cube.x >= -r and cube.y <= r and cube.y >= -r and cube.z <= r and cube.z >= -r

func oddq_to_cube(hex: Vector2i) -> Vector3i:
	var q = hex.x * GRID_CORNER_MULTIPLIER
	var r = hex.y - (hex.x - (int(q) & 1)) / 2 * GRID_CORNER_MULTIPLIER

	return Vector3i(q, r, -q - r)

# Meant to be called by the parent node
func generate_world():
	print('WIDTH: ', width, ' HEIGHT: ', height)

	var biome_tileset_index := randi_range(0, TILE_ATLASES.size()-1)

	for x in range(-width, width):
		for y in range(-height, height):
			if !in_map(x, y):
				continue
			
			var noise_value := noise_heightmap.noise.get_noise_2d(x, y)
			var index := determine_tile_set_index_from_noise(noise_value)
			var atlas_set: Dictionary = TILE_ATLASES[biome_tileset_index][index]
			
			var atlas_offset := weighted_choice(atlas_set.values(), atlas_set.keys())
			
			var sprite := Sprite2D.new()
			self.add_child(sprite)

			var atlas_texture := AtlasTexture.new()
			atlas_texture.region = Rect2i(Vector2i(32, 48) * atlas_offset, Vector2i(32, 48))
			atlas_texture.atlas = atlas
			
			# sprite.z_index = x + y

			sprite.texture = atlas_texture
			sprite.position = GridUtil.get_world_position(x + width * .25, y + height * .25)