extends VBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var message = ""
onready var chat_items = $ChatScrollBox/ChatItems
onready var message_box = $HBoxContainer/MessageBox
onready var global_state = $"/root/GlobalState"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


remote func send_message(new_message):
	chat_items.add_message(new_message)


func _on_MessageBox_text_changed():
	message = message_box.text


func _on_SendButton_pressed():
	var new_message = "[" + global_state.player_name + "]: " + message
	send_message(new_message)
	rpc("send_message", new_message)
	message_box.text = ""
