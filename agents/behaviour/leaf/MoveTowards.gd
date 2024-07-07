extends Task
class_name MoveTowards

@export var navigation: Navigation
@export var blackboard: Blackboard
@export var target_key: String
	
func setup():
	var target_cell: Vector2i = blackboard.get_key(target_key)
	navigation.set_target_cell(target_cell)
	blackboard.add_key("animation", "MOVE")
	
func process():
	if navigation.is_arrived():
		self.state = State.SUCCEEDED
		blackboard.remove_key(target_key)

func find_cell() -> Vector2i:
	return Vector2i.ZERO
