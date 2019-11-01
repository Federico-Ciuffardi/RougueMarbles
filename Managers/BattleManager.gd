extends Node

var chips = []
var current_turn = 0

#public
func start_battle():
	for chip in PartyManager.get_party():
		chips.push_front(chip)
		get_tree().current_scene.add_child(chip)
		chip.position = BattleLib.rand_pos()
	for i in range(0,rand_range(7,11)):
		var chip = ChipLib.create_npc()
		chips.push_front(chip)
		get_tree().current_scene.add_child(chip)
		chip.position = BattleLib.rand_pos()
	chips.sort_custom(self,"sort")
	start_turn()

##turn management
func end_turn():
	#check if game endend
	var counter = 0
	for chip in chips:
		if chip.team == 1:
			counter += 1
	if counter == 0: #defeat
		battle_end()
		get_tree().change_scene_to(preload("res://Menus/GameOver.tscn"))
		return
	elif counter == len(chips):  #victory
		battle_end()
		get_tree().change_scene("res://Battle.tscn")
		return
	#keep going
	next_turn()
	start_turn()

##getters
func get_chips():
	return chips
	
func get_turn_chip():
	return chips[current_turn]
#utils

func remove_chip(chip):
	#re ajust current turn to compensate the removal
	if chips.find(chip) <= current_turn:
		current_turn -= 1
	#erase chip from existence
	chips.erase(chip)
	PartyManager.remove_chip(chip)
	chip.queue_free()


#private
func battle_end():
	for chip in PartyManager.get_party():
		get_tree().current_scene.remove_child(chip)
	chips.clear()
	current_turn = 0
	
func sort(a,b):
	return a.att_manager.get("AGI") < b.att_manager.get("AGI")

##turn management
func start_turn():
	chips[current_turn].start_turn()
	
func next_turn():
	current_turn = (current_turn + 1)  % len(chips)


