extends Task
class_name ChooseTrap

@export var blackboard: Blackboard

func setup():
	var trap = blackboard.get_key("traps").pop_front()
	blackboard.add_key("trap_location", trap.location)
	var stats = blackboard.get_key("stats")
	var trap_challenge: SkillUse = ChallengeUtils.attempt_skill(stats, trap.template)
	blackboard.add_key("trap_stamina", trap_challenge.stamina_use)
	blackboard.add_key("trap_stat", trap_challenge.get_skill_choice())
	var stamina_rate = blackboard.get_key("stamina_rate")
	blackboard.add_key("trap_duration", trap_challenge.stamina_use / stamina_rate)
	blackboard.add_key("wait_animation", trap_challenge.get_skill_str())

func process():
	self.state = State.SUCCEEDED
