extends Task
class_name Inverter

func process():
	var new_state = get_child(0).run()
	if new_state == State.SUCCEEDED:
		self.state = State.FAILED
		
	if new_state == State.FAILED:
		self.state = State.SUCCEEDED
