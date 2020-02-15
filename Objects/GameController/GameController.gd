extends Node2D

var producer_scene = load("res://Objects/Producer/Producer.tscn")
var producer_texture = load("res://Objects/Producer/producer-top.png")

var belt_scene = load("res://Objects/ConveyerBelt/conveyer-belt.tscn")
var belt_texture = load("res://Objects/ConveyerBelt/icon.png")

enum placing_modes { BELT, BANANA }
var object_selected = placing_modes.BANANA

var placement_ghost : Sprite;
var money : int = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	print_debug(get_tree().get_network_peer())
	placement_ghost = get_node("PlacementGhost")
	_change_placement_ghost()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	# Mouse in viewport coordinates
	if event is InputEventMouseButton && not event.pressed:
		if event.button_index == BUTTON_LEFT:
			place_object(object_selected, placement_ghost.position, placement_ghost.rotation)
			rpc("remote_place_object", object_selected, placement_ghost.position, placement_ghost.rotation)
		elif event.button_index == BUTTON_RIGHT:
			if object_selected == placing_modes.BANANA:
				object_selected = placing_modes.BELT
				_change_placement_ghost()
				
			elif object_selected == placing_modes.BELT:
				object_selected = placing_modes.BANANA
				_change_placement_ghost()
	elif event.is_action_released("rotate"):
		placement_ghost.rotate_90()
		

func place_object(a_object_selected, place_position, place_rotation):
	var placing_obj
	if a_object_selected == placing_modes.BANANA:
		placing_obj = producer_scene.instance()
		placing_obj.connect("produce", self, "_produce")
		
	elif a_object_selected == placing_modes.BELT:
		placing_obj = belt_scene.instance()

	placing_obj.position = place_position
	placing_obj.rotation = place_rotation
	add_child(placing_obj)

remote func remote_place_object(a_object_selected, place_position, place_rotation):
	place_object(a_object_selected, place_position, place_rotation)

func _change_placement_ghost():
	if object_selected == placing_modes.BANANA:
		placement_ghost.texture = producer_texture
		
	elif object_selected == placing_modes.BELT:
		placement_ghost.texture = belt_texture

func _produce(Item, position, rotation):
	var placing_obj = Item.instance()
	placing_obj.position = position
	placing_obj.rotation = rotation
	placing_obj.connect("blow_up", self, "remove_obj")
	add_child(placing_obj)

func _on_Consumer_consume(body):
	body.queue_free()
	money += 1
	
func _process(delta):
	$CanvasLayer/PanelContainer/Money.text = "Money: " + String(money)
	
func remove_obj(obj):
	remove_child(obj)
