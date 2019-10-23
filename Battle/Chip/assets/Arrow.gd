extends Sprite

var MAX_X_SIZE = transform.get_scale().x
var MAX_Y_SIZE = transform.get_scale().y
export var MIN_X_SIZE = 0.01

func set_visibility(b):
	if b == true:
		show()
	else:
		hide()

func set_size(prop):
	scale=Vector2(clamp(prop*MAX_X_SIZE,MIN_X_SIZE,MAX_X_SIZE),MAX_Y_SIZE)
	
func set_rotation(angle):
	rotation = angle