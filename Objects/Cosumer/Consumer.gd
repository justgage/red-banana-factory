extends Node2D

signal consume(body)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Area2D_body_entered(body):
	emit_signal("consume", body)
