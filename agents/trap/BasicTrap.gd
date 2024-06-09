extends Node2D
class_name BasicTrap

@export var template: ChallengeStats

func _ready():
	$Sprite2D.texture = template.sprite
