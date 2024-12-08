class_name HexGrid extends Node2D

const CELL_VERTICAL_OFFSET := 0.45
const ODD_CELL_RIGHT_OFFSET := 0.75
const CELL_RIGHT_OFFSET := 1.5

var width: int
var height: int

var cell_size: float

static func get_world_position(c: int, r: int) -> Vector2:
	var is_odd = abs(r) % 2 == 1
	var offset = (Vector2(1,0) * cell_size * ODD_CELL_RIGHT_OFFSET) if is_odd else Vector2.ZERO

	var x_coord: Vector2 = Vector2(c, 0) * cell_size * CELL_RIGHT_OFFSET
	var y_coord: Vector2 = Vector2(0, r) * cell_size * CELL_VERTICAL_OFFSET + offset

	return x_coord + y_coord + self.position

static func get_cell_position()