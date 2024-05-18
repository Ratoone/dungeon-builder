extends Node2D

@onready
var navigation_agent = $NavigationAgent2D
var movement_delta: float
@export var movement_speed: float = 4.0
@export var tile_map: TileMap

func _ready() -> void:
	navigation_agent.velocity_computed.connect(Callable(_on_velocity_computed))
	set_target_cell(Vector2i(-4, 3))

func _physics_process(delta):
	if navigation_agent.is_navigation_finished():
		return

	movement_delta = movement_speed * delta
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	var new_velocity: Vector2 = global_position.direction_to(next_path_position) * movement_delta
	if navigation_agent.avoidance_enabled:
		navigation_agent.set_velocity(new_velocity)
	else:
		_on_velocity_computed(new_velocity)
		
func set_target_cell(cell: Vector2i):
	navigation_agent.set_target_position(tile_map.map_to_local(cell))

func _on_velocity_computed(safe_velocity: Vector2) -> void:
	get_parent().global_position = global_position.move_toward(global_position + safe_velocity, movement_delta)
