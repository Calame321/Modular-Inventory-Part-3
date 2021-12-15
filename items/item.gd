class_name Item extends TextureRect

var id
var item_name
var equipment_type = Game_Enums.EQUIPMENT_TYPE.NONE
var stack_size : int = 1
var quantity : int = 1 setget set_quantity
var level : int = 1
var components = {}

var lbl_quantity

func _init( item_id, data ):
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	id = item_id
	item_name = data.name
	level = data.level
	texture = ResourceManager.sprites[ id ]
	
	if data.has( "stack_size" ):
		stack_size = data.stack_size
	
	if data.has( "type" ):
		equipment_type = Game_Enums.EQUIPMENT_TYPE[ data.type ]
	
	if data.has( "base_stats" ):
		components[ "base_stats" ] = Base_stat.new( data.base_stats, randf() )

func _ready():
	lbl_quantity = Label.new()
	lbl_quantity.set( "custom_fonts/font", ResourceManager.fonts[ 8 ] )
	lbl_quantity.set( "custom_colors/font_color", Color.black )
	add_child( lbl_quantity )
	set_quantity( quantity )

func set_quantity( value ):
	quantity = value
	
	if lbl_quantity:
		lbl_quantity.text = str( quantity )
		lbl_quantity.visible = quantity > 1

func add_item_quantity( value ):
	var remainder = quantity + value - stack_size
	quantity = min( quantity + value, stack_size )
	set_quantity( quantity )
	return remainder



