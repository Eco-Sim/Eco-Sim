extends Node

const CELL_VERTICAL_OFFSET := 0.45
const ODD_CELL_RIGHT_OFFSET := 0.75
const CELL_RIGHT_OFFSET := 1.5

const CELL_SIZE = 32.0

const IS_INVERTED = true

const ODD_CELL_OFFSET = CELL_SIZE * ODD_CELL_RIGHT_OFFSET

static func get_world_position(c: int, r: int) -> Vector2:
	var is_odd = abs(r) % 2 == 1
	var offset := Vector2(ODD_CELL_OFFSET, 0) if is_odd else Vector2.ZERO

	var x_coord: Vector2 = Vector2(c, 0) * CELL_SIZE * CELL_RIGHT_OFFSET
	var y_coord: Vector2 = Vector2(0, r) * CELL_SIZE * CELL_VERTICAL_OFFSET + offset
	
	return x_coord + y_coord

static func get_cell_position(position: Vector2) -> Vector2i: ## reverse formulas in get_world_position(...)
	var column := position.x / (CELL_SIZE * CELL_RIGHT_OFFSET)
	var is_row_odd: bool = fmod(position.y - CELL_SIZE * ODD_CELL_RIGHT_OFFSET, CELL_SIZE * CELL_VERTICAL_OFFSET) >= 4.8
	var row := position.y / (CELL_SIZE * CELL_VERTICAL_OFFSET) - (ODD_CELL_OFFSET if is_row_odd else 0.0)
	return Vector2i(int(column), round(row))
