class_name Item_Info extends NinePatchRect

export( NodePath ) onready var item_name = get_node( item_name ) as Label
export( NodePath ) onready var line_container = get_node( line_container ) as Control

var type_names = {
	Game_Enums.EQUIPMENT_TYPE.NONE: "Material",
	Game_Enums.EQUIPMENT_TYPE.HEAD: "Head",
	Game_Enums.EQUIPMENT_TYPE.CHEST: "Armor",
	Game_Enums.EQUIPMENT_TYPE.OFFHAND: "Offhand",
	Game_Enums.EQUIPMENT_TYPE.MAIN_HAND: "Weapon"
}

func display( slot : Inventory_Slot ):
	for c in line_container.get_children():
		line_container.remove_child( c )
		c.queue_free()
	
	rect_size.x = 0
	rect_global_position = slot.rect_size + slot.rect_global_position
	item_name.text = slot.item.item_name
	var line_type = Item_Info_Line.new( type_names[ slot.item.equipment_type ], "normal" )
	line_container.add_child( line_type )
	
	var components = slot.item.components
	
	if components.has( "base_stats" ):
		line_container.add_child( ResourceManager.tscn.splitter.instance() )
		var base_stat_lines = components.base_stats.get_lines()
		
		for line in base_stat_lines:
			line_container.add_child( line )
	
	show()
	
	yield( get_tree(), "idle_frame" )
	
	var max_width = 0
	var height = 0
	for c in line_container.get_children():
		height += c.rect_size.y + 3
		if c.rect_size.x > max_width:
			max_width = c.rect_size.x
	rect_size = Vector2( max_width + 30, height + 8 )







