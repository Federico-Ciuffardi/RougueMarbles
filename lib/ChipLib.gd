extends Node

onready var PChip = preload("res://Battle/Chip/PChip.tscn")
onready var NPChip = preload("res://Battle/Chip/NPChip.tscn")

func create_pc():
	return PChip.instance()
	
func create_npc():
	return NPChip.instance()