extends Node2D
class_name BaseVisitor

@onready var stamina_bar = $StaminaBar
@onready var navigation: Navigation = $Navigation

@export var template: VisitorStats
@export var tile_map: TileMap
var stamina:float : 
	get:
		return stamina
	set(value):
		stamina = value
		stamina_bar.value = value / template.stamina * 100

func _ready():
	stamina = template.stamina
	navigation.tile_map = tile_map
	navigation.movement_speed = template.speed
	$Sprite2D.texture = template.challenge_stats.sprite
	
func _physics_process(delta):
	global_position = navigation.step_movement()

func _on_trap_triggered(trap_area):
	var trap: BasicTrap = trap_area.get_owner()
	var skill: SkillUse = ChallengeUtils.attempt_skill(template.challenge_stats, trap.template)
	stamina -= skill.stamina_use
