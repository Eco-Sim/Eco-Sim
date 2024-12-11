extends Node

var CELL_VERTICAL_OFFSET := 0.45
var ODD_CELL_RIGHT_OFFSET := 0.75
var CELL_RIGHT_OFFSET := 1.5

var CELL_SIZE := 32.0

var IS_INVERTED := true

var ODD_CELL_OFFSET := CELL_SIZE * ODD_CELL_RIGHT_OFFSET

func get_world_position(c: int, r: int) -> Vector2:
	var is_odd: bool = abs(r) % 2 == 1
	var odd_offset: float = ODD_CELL_OFFSET if is_odd else 0.0

	var x_coord := Vector2(c, 0) * CELL_SIZE * CELL_RIGHT_OFFSET + Vector2(odd_offset, 0)
	var y_coord := Vector2(0, r) * CELL_SIZE * CELL_VERTICAL_OFFSET

	return x_coord + y_coord

func round_to_multiple(x: Variant, base: float) -> float:
	return base * round(x / base)

func get_cell_position(position: Vector2) -> Vector2i: ## reverse formulas in get_world_position(...) aka approximate
	var rounded_position = Vector2(round_to_multiple(position.x, ODD_CELL_OFFSET * 0.5), round_to_multiple(position.y, CELL_SIZE * 0.5))

	var column: int = floori(rounded_position.x / (CELL_SIZE * CELL_RIGHT_OFFSET))
	if rounded_position.x == column * CELL_SIZE * CELL_RIGHT_OFFSET + ODD_CELL_OFFSET:
		pass
	elif rounded_position.x == column * CELL_SIZE * CELL_RIGHT_OFFSET:
		pass
	else:
		if rounded_position.x > column * CELL_SIZE * CELL_RIGHT_OFFSET:
			pass
		else:
			column -= 1

	var row: int = floori(rounded_position.y / (CELL_SIZE * CELL_VERTICAL_OFFSET))

	return Vector2i(column, row)
