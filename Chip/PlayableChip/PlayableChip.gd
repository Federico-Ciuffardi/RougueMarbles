extends Node2D

onready var arrow = $Chip/GUI/Arrow
onready var chip = $Chip

var MAX_FORCE_LENGHT = 200

var aiming = false
var moves_remaining = false

func _ready():
	chip.team = 1
	
func _input(event):
	if moves_remaining:
		if event is InputEventMouse:
			if event.is_action_pressed("touch"):
				aiming = true
				arrow.set_visibility(aiming)
			if aiming:
				var pointerPos = event.position
				var centerPos = chip.global_position
				
				var iVect = centerPos-pointerPos
				
				var iVectProp = clamp(iVect.length()/MAX_FORCE_LENGHT,0,1)
				var iVectAngle = iVect.angle() 
				
				arrow.set_rotation(iVectAngle)
				arrow.set_size(iVectProp)
				
				if event.is_action_released("touch"):
					aiming = false
					arrow.set_visibility(aiming)
					
					chip.impulse(iVectProp,iVectAngle)
					moves_remaining = false

func _on_Chip_turn_started():
	moves_remaining = true
