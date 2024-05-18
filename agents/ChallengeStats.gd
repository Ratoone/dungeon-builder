class_name ChallengeStats

var might: int = 0
var dex: int = 0
var wits: int = 0

func _init(might_stat: int, dex_stat: int, wits_stat: int):
	might = might_stat
	dex = dex_stat
	wits = wits_stat

func attempt_skill(other: ChallengeStats):
	assert(might != 0)
	assert(dex != 0)
	assert(wits != 0)
	var might_effort = 1.0 * other.might * other.might / might
	var dex_effort = 1.0 * other.dex * other.dex / dex
	var wits_effort = 1.0 * other.wits * other.wits / wits
	
	var lowest_effort = 0
	var skill_use = 0
	if might_effort <= dex_effort and might_effort <= wits_effort:
		lowest_effort = might_effort
		skill_use += 1 << 0
		
	if dex_effort <= might_effort and dex_effort <= wits_effort:
		lowest_effort = dex_effort
		skill_use += 1 << 1
	
	if wits_effort <= might_effort && wits_effort <= dex_effort:
		lowest_effort = wits_effort
		skill_use += 1 << 2
		
	return SkillUse.new(skill_use, lowest_effort)
