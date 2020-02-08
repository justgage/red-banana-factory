extends Control

enum types { client, server, unknown }

const SERVER_PORT = 8778
const MAX_PLAYERS = 4
var server_ip = "";
var player_name = ""

var first_names = ["Ib", "Leyroy", "Hulk", "Link", "Harrold"]
var last_names = ["Longbottom", "Fist", "Jenkins", "Chain", "Ob"]

onready var status_text = $VBox/ConnectedStatus
onready var player_list = $"VBox/Player List/Players"

# Player info, associate ID to data
var player_info = {}
# Info we send to other players
var my_info = { name = player_name }

# Called when the node enters the scene tree for the first time.
func _ready():
	print_debug(get_tree().connect("network_peer_connected", self, "_player_connected"))
	print_debug(get_tree().connect("network_peer_disconnected", self, "_player_disconnected"))
	print_debug(get_tree().connect("connected_to_server", self, "_connected_ok"))
	print_debug(get_tree().connect("connection_failed", self, "_connected_fail"))
	print_debug(get_tree().connect("server_disconnected", self, "_server_disconnected"))

func _player_connected(id):
	# Called on both clients and server when a peer connects. Send my info to it.
	rpc_id(id, "register_player", my_info)

func _player_disconnected(id):
	player_info.erase(id) # Erase player from info.

func _connected_ok():
	status_text.text = "Connected to Server"

func _server_disconnected():
	status_text.text = "Sever disconnected"

func _connected_fail():
	status_text.text = "Failed to connect to server"

remote func register_player(info):
	var id = get_tree().get_rpc_sender_id()
	print("player registered")	
	player_info[id] = info
	refresh_player_list()

func refresh_player_list():
	for player_label in player_list.get_children():
		player_label.queue_free()
	for i in player_info:
		var player_label = Label.new()
		player_label.text = player_info[i].name;
		player_list.add_child(player_label)

func start_server():
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(SERVER_PORT, MAX_PLAYERS)
	get_tree().set_network_peer(peer)
	status_text.text = "Hosting... waiting for players"
	register_player(my_info)

func start_client():
	print("creating client")
	var peer = NetworkedMultiplayerENet.new()
	var error = peer.create_client(server_ip, SERVER_PORT) > 0
	get_tree().set_network_peer(peer)
	status_text.text = "Connecting to Server..."
	

func randomize_name():
	var first_name = randi() % 10
	var last_name = randi() % 10
	set_name(first_name + " " + last_name)
	
func set_name(name):
	player_name = name
	$VBox/NameHbox/NameEdit.text = name
	my_info = { name = player_name } 

func _on_ConnectButton_pressed():
	start_client()


func _on_NameEdit_text_changed():
	player_name = $VBox/NameHbox/NameEdit.text
	my_info = { name = player_name } 


func _on_HostServer_pressed():
	start_server()


func _on_Timer_timeout():
	print_debug(get_tree().get_network_peer())
	print_debug(player_info)
	print_debug(server_ip)


func _on_ServerIPInput_text_changed():
	server_ip = $VBox/TabContainer/ClientTab/Vbox/Hbox/ServerIPInput.text