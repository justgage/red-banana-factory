extends Node2D

var Item = load("res://Objects/Bannas/Red-bannana.tscn");

signal produce(Item, position, rotation)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Timer_timeout():
	emit_signal("produce", Item, position, rotation)