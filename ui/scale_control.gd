class_name Scale_Control extends Control

var scale : float

func _ready():
	SignalManager.connect( "ui_scale_changed", self, "_on_ui_scale_changed" )
	set_scale( SettingsManager.scale )

func set_scale( value ):
	scale = value
	rect_scale = Vector2( scale, scale )

func _on_ui_scale_changed( value ):
	set_scale( value )
