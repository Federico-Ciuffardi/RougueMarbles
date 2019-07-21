extends Node

###chip management
var chips = []

func add_chip(chip):
	chips.append(chip)

func remove_chip(chip):
	var i = chips.find(chip)
	#re ajust current turn to compensate the removal
	if i <= current_turn:
		current_turn -= 1
	chips.remove(i)

###turn management

var current_turn = 0

func start_turn():
	chips[current_turn].start_turn()

func next_turn():
	current_turn = (current_turn + 1)  % len(chips)
	
func end_turn():
	next_turn()
	start_turn()


###utilities functions
func get_closest_to(point,team):
	var first
	for i in range(0,len(chips)):
		if chips[i].team == team:
			first = i
			break
	if first == null:
		return null
		
	var minDistanceChip = chips[first]
	var minDistance = (minDistanceChip.global_position-point).length()
	for j in range(first+1,len(chips)):
		if chips[j].team == team:
			var distance = (chips[j].global_position-point).length()
			if minDistance > distance:
				minDistanceChip = chips[j]
				minDistance = distance
	return minDistanceChip.global_position