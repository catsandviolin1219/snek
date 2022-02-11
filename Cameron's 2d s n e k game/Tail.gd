extends Area2D

var turn_locations = []
var directions_turned = []
var cur_dir = Vector2()
const SPEED = 32

func add_direction(head_pos, dir):
	turn_locations.append(head_pos)
	directions_turned.append(dir)

func timeout():
	if (turn_locations.size() > 0):
		if (position == turn_locations[0]):
			cur_dir = directions_turned[0]
			turn_locations.remove(0)
			directions_turned.remove(0)