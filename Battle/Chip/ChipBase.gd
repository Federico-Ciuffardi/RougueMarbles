extends RigidBody2D
##variables

#Childs
onready var hp_manager = $HpManager
onready var turn_indicator = $GUI/TurnIndicator
onready var att_manager = $GUI/TurnIndicator/AttManager

#Constants
var BASE_LINEAR_DAMP = linear_damp
var LINEAR_VEL_MIN = 5
var LINEAR_VEL_TRESH = 200 
var MIN_HP = 20

#Attributtes
var max_impulse = 100*10

#State
var playing_turn = false 
var ap = 0
var team = 0

##Functions
##Initialization
func _ready():
	att_manager.initialize(1)
	hp_manager.initialize(MIN_HP+att_manager.get("END")*3)
	
##Turn management
func start_turn():
	turn_indicator.show()
	playing_turn = true
	ap = 1

func end_turn():
	turn_indicator.hide()
	playing_turn = false
	BattleManager.end_turn()#turn ends when chip stops ()

#hp<=0
func _on_HpManager_death():
	BattleManager.remove_chip(self)
	queue_free()
	if playing_turn:
		end_turn()

##Movement
#apply an impuse to the chip
func impulse(iProp,iDir):
	ap -= 1
	apply_central_impulse(Vector2.RIGHT.rotated(iDir)*clamp(iProp,0,1)*max_impulse)

#called when chip stops moving
func stoped():
	if playing_turn && ap == 0:
		end_turn()

#called when self collides with body
func _on_Chip_body_entered(body):
	if body.name.find("Chip") != -1:
		if not playing_turn and team != BattleManager.get_turn_chip().team:
			var base_dmg = (linear_velocity.length()+body.linear_velocity.length())/200
			var dmg = round(base_dmg*(1+body.att_manager.get("STR")/3))
			hp_manager.damage(dmg)
	elif body.name.begins_with("Wall"):
		if not playing_turn:
			var dmg = round(linear_velocity.length()/100)
			hp_manager.damage(dmg)
	elif body.name.begins_with("Trap"):
		var dmg = round(linear_velocity.length()/25)
		hp_manager.damage(dmg)
		
#tick delta time after last tick 
#used for:
	#linear_damp tunning to simulate top down friction
	#knowing when chip stops
func _physics_process(delta):
	var v = linear_velocity.length()
	if v < LINEAR_VEL_MIN:
		linear_velocity = Vector2.ZERO
		stoped()
	elif v < LINEAR_VEL_TRESH:
		linear_damp = BASE_LINEAR_DAMP*(1 + ((LINEAR_VEL_TRESH-v)/LINEAR_VEL_TRESH))
	else:
		linear_damp = BASE_LINEAR_DAMP