class_name Base_stat extends Resource

var stat_ranges = []
var scale : float

func _init( data, value ):
	scale = value
	
	for stat_range in data:
		stat_ranges.append( Stat_Range.new( stat_range ) )

func get_lines():
	var lines = []
	
	for stat_range in stat_ranges:
		var stat_info = ResourceManager.stat_info[ stat_range.stat ]
		var value = stat_range.get_value( scale, stat_range.stat )
		var text = stat_info.display.replace( "#", str( value ) )
		lines.append( Item_Info_Line.new( text, "normal" ) )
	
	return lines
