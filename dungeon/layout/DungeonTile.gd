class_name DungeonTile

var tile_type: String
var position: Vector2i
var other: Dictionary


func _init(type: String, pos: Vector2i, other_data={}):
	position = pos
	tile_type = type
	other = other_data
