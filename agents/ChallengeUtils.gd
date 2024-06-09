class_name ChallengeUtils

static func attempt_skill(current: ChallengeStats, other: ChallengeStats) -> SkillUse:
	assert(current.might != 0)
	assert(current.dex != 0)
	assert(current.wits != 0)
	var might_effort = calculate_effort(current.might, other.might)
	var dex_effort = calculate_effort(current.dex, other.dex)
	var wits_effort = calculate_effort(current.wits, other.wits)
	
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

static func calculate_effort(own_skill: int, other_skill: int) -> float:
	return 1.0 * other_skill * other_skill / own_skill
