extends Sprite

var speed = 25

func _ready():
	pass

func _process(delta):
	position.x += speed * delta
	if (position.x > 1536):
		position.x = -512