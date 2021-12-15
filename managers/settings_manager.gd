extends Node

var fullscreen setget set_fullscreen
var scale setget set_scale

func _ready():
	scale = 1
	fullscreen = OS.window_fullscreen

func set_fullscreen( value ):
	fullscreen = value
	OS.window_fullscreen = value

func set_scale( value ):
	scale = value
	SignalManager.emit_signal( "ui_scale_changed", value )
