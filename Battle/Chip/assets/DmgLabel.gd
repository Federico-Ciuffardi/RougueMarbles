extends Label

var DELTA_POS = 60
var MAX_UP_TIME = 2
var up_time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	rect_position.y -= 60
	rect_position.x = -(get_minimum_size()/2).x
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	up_time += delta
	rect_position.y -=(delta/MAX_UP_TIME)*DELTA_POS*(MAX_UP_TIME-up_time)
	if(up_time>MAX_UP_TIME):
		queue_free()
