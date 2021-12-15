extends Control

export( NodePath ) onready var settings = get_node( settings ) as Control

func _on_settings_pressed():
	settings.visible = ! settings.visible
	settings.raise()
