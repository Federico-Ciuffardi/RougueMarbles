extends Node

###utilities functions
func get_closest_to(point,team):
	var first
	var chips = BattleManager.get_chips()
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
	
func rand_pos():
	var x = rand_range(0,ProjectSettings.get_setting("display/window/size/width"))
	var y = rand_range(0,ProjectSettings.get_setting("display/window/size/height"))
	return Vector2(x,y)