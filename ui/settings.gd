extends Dragable_Control

export( NodePath ) onready var scale_slider = get_node( scale_slider ) as HSlider
export( NodePath ) onready var fullscreen_check = get_node( fullscreen_check ) as CheckBox


func _ready():
	fullscreen_check.pressed = SettingsManager.fullscreen


func _on_close_pressed():
	hide()


func _on_scale_slider_gui_input( event ):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and not event.pressed:
		SettingsManager.scale = scale_slider.value


func _on_CheckBox_toggled( button_pressed ):
	SettingsManager.fullscreen = button_pressed
