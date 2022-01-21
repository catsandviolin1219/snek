extends Node2D

var direction
var speed
var time

var prev_dir
var tail

func _ready():
	tail = preload("res://Tail.tscn")
	
	speed = 32
	direction = Vector2(1, 0)
	prev_dir = direction
	time = get_node("MoveTimer").time_left

func _process(delta):
	if (Input.is_action_just_pressed("ui_up")):
		direction = Vector2(0, -1)
		move_snake()
		get_node("MoveTimer").start(time)
	if (Input.is_action_just_pressed("ui_down")):
		direction = Vector2(0, 1)
		move_snake()
		get_node("MoveTimer").start(time)
	if (Input.is_action_just_pressed("ui_left")):
		direction = Vector2(-1, 0)
		move_snake()
		get_node("MoveTimer").start(time)
	if (Input.is_action_just_pressed("ui_right")):
		direction = Vector2(1, 0)
		move_snake()
		get_node("MoveTimer").start(time)

func move_snake():
	var head_pos = get_node("Head").position
	get_node("Head").position += direction * speed
	if (prev_dir != direction):
		prev_dir = direction
		for i in range(2, get_child_count()):
			get_child(i).add_direction(head_pos, direction)

func _on_MoveTimer_timeout():
	move_snake()

func _on_Head_area_entered(area):
	if (area.is_in_group("apple")):
		randomize()
		var game = get_tree().get_root().get_node("Game")
		game.get_node("Apple" + str(area.appleID)).position = Vector2((randi() % int(game.width / 32)) * 32 + 16, (randi() % int(game.height / 32)) * 32 + 16)

func add_tail():
	var newTail = tail.instance()
	var prev_tail = get_child(get_child_count()-1)
	if (prev_tail.name != "Head"):
		newTail.cur_dir = prev_tail.cur_dir
		for i in range(0, prev_tail.turn_locations.size()):
			newTail.turn_locations.append(prev_tail.turn_locations[i])
			newTail.directions_turned.append(prev_tail.directions_turned[i])
		newTail.position = prev_tail.position - (prev_tail.cur_dir * speed)
	else:
		newTail.cur_dir = direction
		newTail.position = prev_tail.position - (direction * speed)