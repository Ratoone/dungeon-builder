extends Task
class_name ChooseTrap

@export var blackboard: Blackboard

func setup():
	var trap = blackboard.get_key("traps").pop_front()
	blackboard.add_key("trap_location", trap.location)
	blackboard.add_key("trap_duration", trap.duration)
	blackboard.add_key("trap_stamina", trap.stamina)

func process():
	self.state = State.SUCCEEDED
