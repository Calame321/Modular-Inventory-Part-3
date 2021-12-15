class_name Dragable_Control extends Scale_Control

export ( int ) var safe_zone = 30

var screen_size : Vector2
var dragging : bool = false
var offset : Vector2

func _ready():
	connect( "gui_input", self, "_on_gui_input" )
	screen_size = get_viewport().get_visible_rect().size


func _process( delta ):
	if dragging:
		set_pos( get_viewport().get_mouse_position() - offset )


func set_scale( value ):
	.set_scale( value )
	
	#set_pos( rect_position )


func set_pos( pos ):
	var scaled_size = rect_size * scale
	pos.x = clamp( pos.x, -scaled_size.x + safe_zone, screen_size.x - safe_zone )
	pos.y = clamp( pos.y, -scaled_size.y + safe_zone, screen_size.y - safe_zone )
	rect_position = pos

func _on_gui_input( event : InputEvent ):
	if ! dragging and event.is_action_pressed( "left_click" ):
		var mouse_pos = get_viewport().get_mouse_position()
		offset = mouse_pos - rect_position
		dragging = true
		get_tree().set_input_as_handled()
		raise()
	
	if dragging and event.is_action_released( "left_click" ):
		dragging = false
		get_tree().set_input_as_handled()
