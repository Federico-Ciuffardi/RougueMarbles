extends Node

var party = []

func new_chip():
	var chip = ChipLib.create_pc()
	party.push_front(chip)

func remove_chip(chip):
	party.erase(chip)

func get_party():
	return party