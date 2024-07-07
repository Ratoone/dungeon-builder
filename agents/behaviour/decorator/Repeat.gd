extends Task
class_name Repeat

@export var repeat_times_key: String
@export var finished_one_event: String
@export var blackboard: Blackboard

var repeats = 0
var limit = 0

func setup():
	assert(get_child_count() == 1)
	limit = blackboard.get_key(repeat_times_key)
	get_child(0).start()

func process():
	var child_state = get_child(0).run()
	if child_state == State.FAILED:
		self.state = State.FAILED
		
	if child_state == State.SUCCEEDED:
		repeats += 1
		get_child(0).start()
		if !finished_one_event.is_empty():
			blackboard.emit_signal(finished_one_event)
		if repeats >= limit:
			repeats = 0
			self.state = State.SUCCEEDED
