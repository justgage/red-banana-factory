extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var push_speed = 20

enum Directions {up, right, down, left}
export var direction = Directions.right

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body is RigidBody2D:
			move_body(body)

func move_body(body: RigidBody2D):
	body.apply_central_impulse(Vector2.RIGHT * push_speed)
	