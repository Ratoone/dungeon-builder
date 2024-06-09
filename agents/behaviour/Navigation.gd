extends Node2D
class_name Navigation

@onready
var navigation_agent = $NavigationAgent2D
var movement_delta: float
var new_velocity: Vector2 = Vector2.ZERO
@export var movement_speed: float = 4.0
@export var tile_map: TileMap


func _physics_process(delta):
	if is_arrived():
		return

	movement_delta = movement_speed * delta
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	new_velocity = global_position.direction_to(next_path_position) * movement_delta
		
func set_target_cell(cell: Vector2i):
	navigation_agent.set_target_position(tile_map.map_to_local(cell))
	
func is_arrived() -> bool:
	return navigation_agent.is_navigation_finished()

func step_movement() -> Vector2:
	return global_position.move_toward(global_position + new_velocity, movement_delta)
