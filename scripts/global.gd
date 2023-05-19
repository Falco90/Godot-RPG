extends Node

var player_current_attack = false
var player_current_pickup = false

var current_scene = "world" #world cliff_side
var transition_scene = false

var player_exit_cliffside_posx = 526
var player_exit_cliffside_posy = 47
var player_start_posx = 526
var player_start_posy = 291

var game_first_loadin = true
var player_message = ""

var player_talking = false

func finish_changescenes():
	if transition_scene == true:
		transition_scene = false
		if current_scene == "world":
			current_scene = "cliff_side"
		else:
			current_scene = "world"
