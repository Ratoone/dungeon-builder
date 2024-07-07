extends Node2D
class_name BaseVisitor

@onready var stamina_bar = $StaminaBar
@onready var navigation: Navigation = $Navigation
@onready var blackboard: Blackboard = $Blackboard
@onready var behaviour_tree: Task = $"Selector - explore Floor"

@export var template: VisitorStats
@export var tile_map: TileMap
@export var layout: DungeonLayout

var current_floor = 0

var stamina:float : 
	get:
		return stamina
	set(value):
		stamina = value
		stamina_bar.value = value / template.stamina * 100
		blackboard.add_key("stamina_percentage", stamina_bar.value)

func _ready():
	blackboard.add_key("stats", template.challenge_stats)
	blackboard.add_key("stamina_rate", 0.4)
	blackboard.add_key("doors", layout.doors_on_floor(current_floor))
	blackboard.add_key("n_rooms", blackboard.get_key("doors").size())
	blackboard.add_user_signal("trap_done")
	blackboard.connect("trap_done", _on_trap_finished)
	stamina = template.stamina
	navigation.tile_map = tile_map
	navigation.movement_speed = template.speed
	$Sprite2D.texture = template.challenge_stats.sprite
	behaviour_tree.start()
	
func _process(_delta):
	var state = behaviour_tree.run()
	if blackboard.get_key("animation") != null:
		$AnimationPlayer.play(blackboard.get_key("animation"))
	if state == behaviour_tree.State.SUCCEEDED:
		queue_free()
	
func _physics_process(_delta):
	global_position = navigation.step_movement()

func _on_trap_finished():
	var stamina_use: float = blackboard.get_key("trap_stamina")
	self.stamina -= stamina_use
	blackboard.remove_key("trap_stamina")
