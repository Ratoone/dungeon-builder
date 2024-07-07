extends Node2D
class_name DungeonLayout

@export var tile_map: TileMap
@export var max_height: int
@export var max_width: int

enum TerrainType {
	WALL,
	FLOOR,
	EXIT
}

var base_layout: Array[DungeonTile] = [
	DungeonTile.new("floor", Vector2i( - 10, -10)),
	DungeonTile.new("floor", Vector2i( - 10, 10)),
	DungeonTile.new("floor", Vector2i(10, 10)),
	DungeonTile.new("floor", Vector2i(10, -10))
]

var exit: Vector2i = Vector2i(0, 0)
@export var traps: Array[BasicTrap]

# Called when the node enters the scene tree for the first time.
func _ready():
	#generate_layout(base_layout)
	_draw_exit()
	pass

func generate_layout(layout: Array[DungeonTile]):
	for i in range( - max_width / 2, max_width / 2):
		for j in range( - max_height / 2, max_height / 2):
			BetterTerrain.set_cell(tile_map, 0, Vector2i(i, j), TerrainType.WALL)
			
	BetterTerrain.update_terrain_area(tile_map, 0, Rect2i( - max_width / 2, -max_height / 2, max_width, max_height))

	for cell_index in range(layout.size()):
		var current_point = layout[cell_index].position
		
		BetterTerrain.set_cell(tile_map, 0, Vector2i(current_point.x, current_point.y), TerrainType.FLOOR)
		BetterTerrain.update_terrain_cell(tile_map, 0, Vector2i(current_point.x, current_point.y))
		
	_draw_exit()
	
func _draw_exit():
	BetterTerrain.set_cell(tile_map, 0, exit, TerrainType.EXIT)
	BetterTerrain.update_terrain_cell(tile_map, 0, exit)

func _unhandled_input(_event):
	if !Input.is_action_pressed("click"):
		return
	var clicked_pos: Vector2i = tile_map.local_to_map(get_local_mouse_position())
	BetterTerrain.set_cell(tile_map, 0, clicked_pos, 1)
	BetterTerrain.update_terrain_cell(tile_map, 0, clicked_pos)

func traps_for():
	return traps.map(func(trap): return {
		"location": tile_map.local_to_map(trap.global_position),
		"template": trap.template
	})

func doors_on_floor(_floor: int):
	return [ {
		"location": exit,
		"template": ChallengeStats.new(),
		"traps": traps_for()
	},
	{
		"location": exit,
		"template": ChallengeStats.new(),
		"traps": traps_for()
	},
	{
		"location": exit,
		"template": ChallengeStats.new(),
		"traps": traps_for()
	}
	]
