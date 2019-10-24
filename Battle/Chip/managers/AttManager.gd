extends Node2D
#const
var INIT_ATTS = 8
#vars
var atts_id =  {"STR":1, # damage
				"AGI":2, # turn priority
				"INT":3, # ?
				"END":4, # life
				"LCK":5} # critical
var atts

func initialize(lvl):
	atts = RandLib.dist_sum(INIT_ATTS + lvl*2,len(atts_id))
	
func get(att):
	return atts[atts_id[att]]