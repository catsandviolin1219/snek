extends Node2D

var direction
var speed
var time

var prev_dir
var tail

func _ready():
	
	speed = 32
	direction = Vector2(1, 0)
	prev_dir = Vector2(1, 0)
	tail = preload("res://Tail.tscn")
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
	for i in range(2, get_child_count()):
		var tail = get_child(i)
		tail.position = tail.position + (tail.cur_dir * tail.SPEED)
		tail.timeout()
	head_pos = get_node("Head").position
	if (head_pos.x < -32 or head_pos.x > get_viewport_rect().size.x - 128):
		get_parent().you_are_die()
	if (head_pos.y < -32 or head_pos.y > get_viewport_rect().size.y - 128):
		get_parent().you_are_die()

func _on_MoveTimer_timeout():
	move_snake()

func _on_Head_area_entered(area):
	if (area.is_in_group("apple")):
		randomize()
		var game = get_tree().get_root().get_node("Game")
		game.get_node("Apple" + str(area.appleID)).position = Vector2((randi() % int(game.width / 32)) * 32 + 16, (randi() % int(game.height / 32)) * 32 + 16)
		add_tail()
	if ("Tail" in area.name):
		get_parent().you_are_die()

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
	call_deferred("add_child", newTail)