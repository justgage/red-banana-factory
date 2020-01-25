extends Camera2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 100
var zoom_speed = Vector2.ONE / 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _input(event):
	if event.is_action("ui_left"):
		position += Vector2.LEFT * speed
	if event.is_action("ui_right"):
		position += Vector2.RIGHT * speed
	if event.is_action("ui_up"):
		position += Vector2.UP * speed
	if event.is_action("ui_down"):
		position += Vector2.DOWN * speed
	if event.is_action("zoom_in"):
		zoom += zoom_speed
	if event.is_action("zoom_out"):
		zoom -= zoom_speed
