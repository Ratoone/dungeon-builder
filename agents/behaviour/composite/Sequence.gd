extends Task
class_name Sequence

var current_child = 0

func process():
	var new_state = get_child(current_child).run()
	
	if new_state == State.RUNNING:
		return
	
	if new_state == State.FAILED:
		self.state = new_state
		current_child = 0
		return
		
	if new_state == State.SUCCEEDED:
		current_child += 1
	
	if current_child >= get_child_count():
		current_child = 0
		self.state = new_state
