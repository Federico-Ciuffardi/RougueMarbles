extends Node2D

onready var arrow = $Chip/GUI/Arrow
onready var chip = $Chip


# Called when the node enters the scene tree for the first time.
func _ready():
	chip.team = 2

func _on_Chip_turn_started():
	var current_pos = chip.global_position
	var target_pos = ChipManager.get_closest_to(current_pos,1)
	
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
	
	chip.impulse(target_prop,target_angle)
	arrow.set_visibility(false)

