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