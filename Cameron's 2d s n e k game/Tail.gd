extends Area2D

var turn_locations = []
var directions_turned = []
var cur_dir = Vector2()
const SPEED = 32

func add_direction(head_pos, dir):
	turn_locations.append(head_pos)
	directions_turned.append(dir)