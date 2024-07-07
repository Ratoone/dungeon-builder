extends Task
class_name ChooseDoor

@export var blackboard: Blackboard

func setup():
	var door = blackboard.get_key("doors").pop_front()
	blackboard.add_key("door_location", door.location)
	blackboard.add_key("traps", door.traps)
	blackboard.add_key("n_traps", door.traps.size())
	var stats = blackboard.get_key("stats")
	var door_challenge: SkillUse = ChallengeUtils.attempt_skill(stats, door.template)
	blackboard.add_key("door_stamina", door_challenge.stamina_use)
	blackboard.add_key("door_stat", door_challenge.get_skill_choice())
	var stamina_rate = blackboard.get_key("stamina_rate")
	blackboard.add_key("door_duration", door_challenge.stamina_use / stamina_rate)
	blackboard.add_key("wait_animation", door_challenge.get_skill_str())

func process():
	self.state = State.SUCCEEDED
