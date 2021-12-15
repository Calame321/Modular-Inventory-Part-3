extends Node

export( NodePath ) onready var item_in_hand_node = get_node( item_in_hand_node ) as Control
export( NodePath ) onready var item_info = get_node( item_info ) as Control
export( NodePath ) onready var split_stack = get_node( split_stack ) as Split_Stack

var inventories : Array = []
var item_in_hand : Item = null
var item_offset = Vector2.ZERO

func _ready():
	SignalManager.connect( "inventory_ready", self, "_on_inventory_ready" )
	split_stack.connect( "stack_splitted", self, "_on_stack_splitted" )


func _on_inventory_ready( inventory ):
	inventories.append( inventory )
	
	for slot in inventory.slots:
		slot.connect( "mouse_entered", self, "_on_mouse_entered_slot", [ slot ] )
		slot.connect( "mouse_exited", self, "_on_mouse_exited_slot" )
		slot.connect( "gui_input", self, "_on_gui_input_slot", [ slot ] )

func _input( event : InputEvent ):
	if event is InputEventMouseMotion and item_in_hand:
		item_in_hand.rect_position = event.position - item_offset

func _on_mouse_entered_slot( slot ):
	if slot.item:
		item_info.display( slot )

func _on_mouse_exited_slot():
	item_info.hide()

func _on_gui_input_slot( event : InputEvent, slot : Inventory_Slot ):
	if slot.item and slot.item.quantity > 1 and item_in_hand == null and event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_RIGHT and Input.is_key_pressed( KEY_SHIFT ):
		split_stack.display( slot )
	elif event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		if item_in_hand:
			if slot is Equipment_Slot and item_in_hand.equipment_type != slot.type:
				return
			
			item_in_hand_node.remove_child( item_in_hand )
			
			if slot.item:
				if slot.item.id == item_in_hand.id and slot.item.quantity < slot.item.stack_size:
					var remainder = slot.item.add_item_quantity( item_in_hand.quantity )
					
					if remainder < 1:
						item_in_hand = null
					else:
						item_in_hand_node.add_child( item_in_hand )
						item_in_hand.quantity = remainder
				else:
					var temp_item = slot.item
					slot.pick_item()
					temp_item.rect_global_position = event.global_position - item_offset
					slot.put_item( item_in_hand )
					item_in_hand = temp_item
					item_in_hand_node.add_child( item_in_hand )
			else:
				slot.put_item( item_in_hand )
				item_in_hand = null
			
		elif slot.item:
			item_in_hand = slot.item
			item_offset = event.global_position - item_in_hand.rect_global_position
			slot.pick_item()
			item_in_hand_node.add_child( item_in_hand )
			item_in_hand.rect_global_position = event.global_position - item_offset


func _on_stack_splitted( slot, new_quantity ):
	slot.item.quantity -= new_quantity
	var new_item = ItemManager.get_item( slot.item.id )
	new_item.quantity = new_quantity
	item_in_hand = new_item
	item_in_hand_node.add_child( item_in_hand )




