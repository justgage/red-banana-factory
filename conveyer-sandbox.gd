extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var red_bannana_scene = load("res://Objects/Bannas/Red-bannana.tscn")



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	# Mouse in viewport coordinates
	if event is InputEventMouseButton:
		if not event.pressed:
			var bannana : RigidBody2D = red_bannana_scene.instance()
			bannana.position = get_global_mouse_position()
			add_child(bannana)
	elif event is InputEventMouseMotion:
		print("Mouse Motion at: ", event.position)
	print("Viewport Resolution is: ", get_viewport_rect().size)