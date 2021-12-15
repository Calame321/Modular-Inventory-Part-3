extends Inventory

export( NodePath ) onready var head = get_node( head ) as Inventory_Slot
export( NodePath ) onready var chest = get_node( chest ) as Inventory_Slot
export( NodePath ) onready var offhand = get_node( offhand ) as Inventory_Slot
export( NodePath ) onready var main_hand = get_node( main_hand ) as Inventory_Slot

func _ready():
	slots.append( head )
	slots.append( chest )
	slots.append( offhand )
	slots.append( main_hand )
	SignalManager.emit_signal( "inventory_ready", self )

func set_inventory_size( value ):
	size = value
