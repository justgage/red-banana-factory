extends VBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"



# Called when the node enters the scene tree for the first time.
func _ready():
	refresh_ips();
	pass
	
	
func refresh_ips():
	for child in $AddressesContainer.get_children():
		remove_child(child)
	
	var i = 0;
	for ip in IP.get_local_addresses():
		i += 1;
		var address_node = Button.new()
		address_node.text = ip;
		address_node.connect("pressed", self, "copy_address", [ip])
		address_node.rect_position = rect_position + Vector2(0, i * 25)
		$AddressesContainer.add_child(address_node)
		
func copy_address(ip):
	OS.set_clipboard(ip)

