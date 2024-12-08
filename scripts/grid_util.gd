extends Node

const CELL_VERTICAL_OFFSET := 0.45
const ODD_CELL_RIGHT_OFFSET := 0.75
const CELL_RIGHT_OFFSET := 1.5

const CELL_SIZE = 32

static func get_world_position(c: int, r: int) -> Vector2:
	var is_odd = abs(r) % 2 == 1
	var offset = (Vector2(1,0) * CELL_SIZE * ODD_CELL_RIGHT_OFFSET) if is_odd else Vector2.ZERO

	var x_coord: Vector2 = Vector2(c, 0) * CELL_SIZE * CELL_RIGHT_OFFSET
	var y_coord: Vector2 = Vector2(0, r) * CELL_SIZE * CELL_VERTICAL_OFFSET + offset

	return x_coord + y_coord

# static func get_cell_position()