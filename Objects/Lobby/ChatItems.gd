extends VBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func add_message(message, right = false):
	var message_label = Label.new()
	message_label.text = message
	if right:
		message_label.align = Label.ALIGN_RIGHT
	add_child(message_label)
	
