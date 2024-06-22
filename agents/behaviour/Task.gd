extends Node
class_name Task

enum State {
	FRESH,
	RUNNING,
	FAILED,
	SUCCEEDED
}

var state: State

func run() -> State:
	if self.state == State.FRESH:
		setup()
		self.state = State.RUNNING
	process()
	return self.state
	
func setup():
	pass
	
func process():
	pass

func start():
	state = State.FRESH
	for child in get_children():
		child.start()
