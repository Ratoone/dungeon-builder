extends Task
class_name WaitFor

@export var waiting_time_key: String
@export var blackboard: Blackboard
var timer: Timer

func setup():
	timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.timeout.connect(_timer_timeout)
	timer.start(blackboard.get_key(waiting_time_key))

func _timer_timeout():
	self.state = State.SUCCEEDED
	blackboard.remove_key(waiting_time_key)
