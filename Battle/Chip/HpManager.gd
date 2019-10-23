extends Node2D

signal death

onready var hpBar = $GUI/HpBar as ProgressBar
onready var hpLabel = $GUI/HpLabel as Label

var maxHp = -1 setget set_maxHp
var hp = -1 setget set_hp

func initialize(maxHp):
	hpBar.min_value = 0
	self.maxHp = maxHp
	self.hp = maxHp
	

func set_maxHp(val):
	maxHp = val
	update_GUI()

func set_hp(val):
	hp = val
	update_GUI()
	if hp <= 0:
		emit_signal("death")
	
func damage(dmg):
	self.hp = hp - dmg

func update_GUI():
	hpBar.max_value = maxHp
	hpBar.value = hp
	hpLabel.text = str(hp)+"/"+str(maxHp)