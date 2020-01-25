extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var push_speed = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body is RigidBody2D:
			move_body(body)

func move_body(body: RigidBody2D):
	var heading_vector = Vector2(cos(global_rotation), sin(global_rotation)) 
	body.apply_central_impulse(
		heading_vector * push_speed
	)
	