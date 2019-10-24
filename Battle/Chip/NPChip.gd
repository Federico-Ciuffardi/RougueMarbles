extends "res://Battle/Chip/ChipBase.gd"

onready var arrow = $GUI/Arrow

# Called when the node enters the scene tree for the first time.
func _ready():
	team = 2

func start_turn():
	.start_turn()
	var current_pos = global_position
	var target_pos = BattleLib.get_closest_to(current_pos,1)
	
	var target_angle = (target_pos -current_pos).angle()
	var target_prop = 1
	
	arrow.set_visibility(true)
	arrow.set_rotation(target_angle)
	arrow.set_size(target_prop)
	
	var t = Timer.new()
	t.set_wait_time(2)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t,"timeout")
	t.queue_free()
	
	impulse(target_prop,target_angle)
	arrow.set_visibility(false)

