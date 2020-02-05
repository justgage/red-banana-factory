extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var bodies;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = get_global_mouse_position().snapped(Vector2.ONE * 128)
	bodies = $Area2D.get_overlapping_areas()
	if bodies.empty():
		modulate = Color(1, 1, 1, 0.2)
	else:
		modulate = Color(2, 1, 1, 0.4)

func rotate_90():
	rotation_degrees += 90
	
func get_bodies():
	return bodies;
