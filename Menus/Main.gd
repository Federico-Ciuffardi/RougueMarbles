extends Node

func _ready():
	randomize()
	PartyManager.new_chip()
	PartyManager.new_chip()
	PartyManager.new_chip()
	PartyManager.new_chip()
	PartyManager.new_chip()
	PartyManager.new_chip()
	PartyManager.new_chip()
	PartyManager.new_chip()
	PartyManager.new_chip()
	PartyManager.new_chip()
	PartyManager.new_chip()
	PartyManager.new_chip()
	get_tree().change_scene("res://Battle.tscn")