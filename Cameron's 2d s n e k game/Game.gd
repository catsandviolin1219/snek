extends Node2D

var width
var height

var apple

func _ready():
	apple = preload("res://Apple.tscn")
	width = get_viewport_rect().size.x
	height = get_viewport_rect().size.y
	
	randomize()
	
	var newApple
	
	for i in range(15):
		newApple = apple.instance()
		newApple.name = "Apple" + str(i)
		newApple.appleID = i
		newApple.position = Vector2((randi() % int(width / 32)) * 32 + 16, (randi() % int(height / 32)) * 32 + 16)
		
		add_child(newApple)

func you_are_die():
	var snake_position = get_node("Snake/Head").position
	print(snake_position)
	get_node("Boom").position = snake_position + Vector2(80, 112)
	get_node("Boom").visible = true
	print(get_node("Boom").visible)
	get_node("Snake").queue_free()
	get_node("Death Screen").visible = true

func _process(delta):
	if (Input.is_action_just_pressed("restart")):
		get_tree().reload_current_scene()