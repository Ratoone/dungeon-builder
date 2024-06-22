extends Node2D
class_name BaseVisitor

@onready var stamina_bar = $StaminaBar
@onready var navigation: Navigation = $Navigation
@onready var blackboard: Blackboard = $Blackboard
@onready var behaviour_tree: Task = $"Selector - explore Floor"

@export var template: VisitorStats
@export var tile_map: TileMap
@export var layout: DungeonLayout

var stamina:float : 
	get:
		return stamina
	set(value):
		stamina = value
		stamina_bar.value = value / template.stamina * 100
		blackboard.add_key("stamina_percentage", stamina_bar.value)

func _ready():
	blackboard.add_key("current_floor", 1)
	blackboard.add_key("n_rooms", 1)
	blackboard.add_key("n_traps", 1)
	blackboard.add_key("door_location", Vector2i(0, 0))
	blackboard.add_key("door_duration", 0.1)
	blackboard.add_key("traps", layout.traps.map(func (trap): return {
		"location": tile_map.local_to_map(trap.global_position),
		"duration": 1,
		"stamina": ChallengeUtils.attempt_skill(template.challenge_stats, trap.template).stamina_use
	}))
	blackboard.add_user_signal("trap_done")
	blackboard.connect("trap_done", _on_trap_finished)
	stamina = template.stamina
	navigation.tile_map = tile_map
	navigation.movement_speed = template.speed
	$Sprite2D.texture = template.challenge_stats.sprite
	behaviour_tree.start()
	
func _process(delta):
	blackboard.add_key("location", tile_map.local_to_map(global_position))
	var state = behaviour_tree.run()
	if state == behaviour_tree.State.SUCCEEDED:
		queue_free()
	
func _physics_process(delta):
	global_position = navigation.step_movement()

func _on_trap_triggered(trap_area):
	var trap: BasicTrap = trap_area.get_owner()
	var skill: SkillUse = ChallengeUtils.attempt_skill(template.challenge_stats, trap.template)
	stamina -= skill.stamina_use

func _on_trap_finished():
	var stamina = blackboard.get_key("trap_stamina")
	self.stamina -= stamina
	blackboard.remove_key("trap_stamina")
