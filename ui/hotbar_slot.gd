class_name Hotbar_Slot extends Inventory_Slot

export ( NodePath ) onready var lbl_key = get_node( lbl_key ) as Label

var key

func _ready():
	lbl_key.text = key

func _input( event ):
	if event.is_action_pressed( "hotbar_" + key ):
		print( "Used hotbar slot: ", key )
