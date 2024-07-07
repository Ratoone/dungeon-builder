extends Task
class_name WaitFor

@export var waiting_time_key: String
@export var blackboard: Blackboard
var timer: Timer

func setup():
	var waiting_time = blackboard.get_key(waiting_time_key)
	if waiting_time == 0:
		waiting_time = 0.1
	if timer == null:
		timer = Timer.new()
		add_child(timer)
		timer.one_shot = true
		timer.timeout.connect(_timer_timeout)
	timer.start(waiting_time)
	blackboard.add_key("animation", blackboard.get_key("wait_animation"))

func _timer_timeout():
	self.state = State.SUCCEEDED
	blackboard.remove_key(waiting_time_key)
	timer.queue_free()
