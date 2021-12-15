class_name Equipment_Slot extends Inventory_Slot

export( NodePath ) onready var placeholder = get_node( placeholder ) as TextureRect

export ( Game_Enums.EQUIPMENT_TYPE ) var type

func _ready():
	placeholder.texture = ItemManager.get_placeholder( type )

func set_item( new_item ):
	.set_item( new_item )
	placeholder.hide()

func pick_item():
	.pick_item()
	placeholder.show()

func put_item( new_item ):
	.put_item( new_item )
	placeholder.hide()
