class_name SkillUse

var skill_choice: int = 0
var stamina_use: float = 0

func _init(skill: int, stamina: float):
	skill_choice = skill
	stamina_use = stamina

func get_skill_choice() -> ChallengeUtils.Stat:
	return ChallengeUtils.decode_skill_use(skill_choice)

func get_skill_str() -> String:
	return ChallengeUtils.skill_to_str(get_skill_choice())
	
