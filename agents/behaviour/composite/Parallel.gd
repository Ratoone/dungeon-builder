extends Task
class_name Parallel

enum Policy { SEQUENCE, SELECTOR }

@export var policy: Policy = Policy.SEQUENCE

func process():
	var success = 0
	var failure = 0
	
	for child: Task in get_children():
		var new_state = child.run()
		if new_state == State.SUCCEEDED:
			success += 1
			if policy == Policy.SELECTOR:
				self.state = State.SUCCEEDED
				return
		if new_state == State.FAILED:
			failure += 1
			if policy == Policy.SEQUENCE:
				self.state = State.FAILED
				return
	
	if policy == Policy.SEQUENCE && success >= get_child_count():
		self.state = State.SUCCEEDED
		return
	
	if policy == Policy.SELECTOR && failure >= get_child_count():
		self.state = State.FAILED
		return
