extends Task
class_name WaitFor

@export var waiting_time: float
var timer: Timer

func setup():
	timer = Timer.new()
	timer.one_shot = true
	timer.timeout.connect(_timer_timeout)
	timer.start(waiting_time)

func _timer_timeout():
	self.state = State.SUCCEEDED
