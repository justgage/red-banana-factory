extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var red_bannana_scene = load("res://Objects/Bannas/Red-bannana.tscn")
var bananas_texture = load("res://Objects/Bannas/red-bannana.png")

var belt_scene = load("res://Objects/ConveyerBelt/conveyer-belt.tscn")
var belt_texture = load("res://Objects/ConveyerBelt/icon.png")

enum placing_modes { BELT, BANANA }
var object_selected = placing_modes.BANANA

var placement_ghost : Sprite;


# Called when the node enters the scene tree for the first time.
func _ready():
	placement_ghost = get_node("PlacementGhost")
	_change_placement_ghost()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	# Mouse in viewport coordinates
	if event is InputEventMouseButton && not event.pressed:
		if event.button_index == BUTTON_LEFT:
			var placing_obj
			if object_selected == placing_modes.BANANA:
				placing_obj = red_bannana_scene.instance()
			elif object_selected == placing_modes.BELT:
				placing_obj = belt_scene.instance()
		
			placing_obj.position = placement_ghost.position
			placing_obj.rotation = placement_ghost.rotation
			add_child(placing_obj)
				
		elif event.button_index == BUTTON_RIGHT:
			if object_selected == placing_modes.BANANA:
				object_selected = placing_modes.BELT
				_change_placement_ghost()
				
			elif object_selected == placing_modes.BELT:
				object_selected = placing_modes.BANANA
				_change_placement_ghost()
	elif event.is_action_released("rotate"):
		placement_ghost.rotate_90()
		
func _change_placement_ghost():
	if object_selected == placing_modes.BANANA:
		placement_ghost.texture = bananas_texture
		
	elif object_selected == placing_modes.BELT:
		placement_ghost.texture = belt_texture