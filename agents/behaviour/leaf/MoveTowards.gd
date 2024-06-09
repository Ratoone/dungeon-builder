extends Task
class_name MoveTowards

@export var navigation: Navigation
@export var blackboard: Blackboard

var target_cell: Vector2i
	
func setup():
	target_cell = blackboard.get_key("target_cell")
	navigation.set_target_cell(target_cell)
	
func process():
	if navigation.is_arrived():
		self.state = State.SUCCEEDED
		blackboard.remove_key("target_cell")
