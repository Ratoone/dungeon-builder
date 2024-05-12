extends Camera2D

@export var min_zoom := 0.1
@export var max_zoom := 5.0
@export var zoom_factor := 0.1
@export var zoom_duration := 0.2
var zoom_level: float = 1

const MOVE_SPEED = 100

func _process(delta):
	if Input.is_action_pressed("ui_left"):
		global_position += Vector2.LEFT * delta * MOVE_SPEED
	if Input.is_action_pressed("ui_right"):
		global_position += Vector2.RIGHT * delta * MOVE_SPEED
	if Input.is_action_pressed("ui_up"):
		global_position += Vector2.UP * delta * MOVE_SPEED
	if Input.is_action_pressed("ui_down"):
		global_position += Vector2.DOWN * delta * MOVE_SPEED
	if Input.is_action_pressed("ui_text_scroll_down"):
		set_zoom_level(zoom_level - zoom_factor)
	if Input.is_action_pressed("ui_text_scroll_up"):
		set_zoom_level(zoom_level + zoom_factor)
		
func set_zoom_level(level: float, mouse_world_position = self.get_global_mouse_position()):
	var old_zoom_level = zoom_level
	
	zoom_level = clampf(level, min_zoom, max_zoom)
	
	var direction = (mouse_world_position - self.global_position)
	var new_position = self.global_position + direction - ((direction) / (zoom_level/old_zoom_level))
	
	self.zoom = Vector2(zoom_level, zoom_level)
	self.global_position = new_position
