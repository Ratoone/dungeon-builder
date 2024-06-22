extends Node
class_name Blackboard

var data: Dictionary = {}

func add_key(key: String, value):
	data[key] = value
	
func remove_key(key: String):
	data.erase(key)

func get_key(key: String):
	return data.get(key)
