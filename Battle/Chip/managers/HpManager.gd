extends Node2D

signal death

onready var hp_bar = $GUI/HpBar as ProgressBar
onready var hp_label = $GUI/HpLabel as Label
onready var DmgLabel = preload("res://Battle/Chip/assets/DmgLabel.tscn")
onready var tween = $GUI/Tween
var animated_health = 0

var maxHp = -1 setget set_maxHp
var hp = -1 setget set_hp

func initialize(maxHp):
	hp_bar.min_value = 0
	self.maxHp = maxHp
	self.hp = maxHp
	animated_health = maxHp
	

func set_maxHp(val):
	maxHp = val
	update_GUI()

func set_hp(newHp):
	hp = newHp
	tween.interpolate_property(self, "animated_health", animated_health, hp, 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN)
	if not tween.is_active():
    	tween.start()
		
	
func damage(dmg):
	if dmg > 0:
		var dmg_label = DmgLabel.instance()
		self.add_child(dmg_label)
		dmg_label.text = "-"+str(dmg)
		var start_color = Color(0.75, 0, 0, 1.0)
		var end_color = Color(0.75, 0, 0, 0.0)
		tween.interpolate_property(dmg_label, "modulate", start_color, end_color, 2.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
		self.hp -= dmg

			
func update_GUI():
	hp_bar.max_value = maxHp
	#hp_bar.value = hp
	#hp_label.text = str(hp)+"/"+str(maxHp)
	
func _process(delta):
	hp_label.text = str(round(animated_health))+"/"+str(maxHp) 
	hp_bar.value = animated_health
	if(animated_health <= 0):
		emit_signal("death")