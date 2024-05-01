extends Node

var health:int = 10
var healthMax:int = 10
var keys:int = 0
var inventory: Array = [null,null,null,null,null,null,null,null,null]

var save = false
var itemList = {}
#списки всех адресов иконок по id
# Called when the node enters the scene tree for the first time.
func _ready():
	itemListInit()
	inventorySort()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	pass

	
func itemListInit():
	itemList[null] = {
		"id" : 0000,
		"name" :  "clear cell",
		"description": "clear cell",
		"icon" : "res://Assets/clear.png",
		"usable" : false,
		"unlimited" : false,
		
	}
	itemList["apple"] = {
		"id" : 0001,
		"name" :  "apple",
		"description": "Are apple. restore +1 hp",
		"icon" : "res://Assets/aple.png",
		"usable" : true,
		"unlimited" : false,
		
	}
	itemList["chili"] = {
		"id" : 0002,
		"name" :  "chili",
		"description": "Reduces the user's health (-1)",
		"icon" : "res://Assets/chili.png",
		"usable" : true,
		"unlimited" : false,
	}
	itemList["amulet"] = {
		"id" : 0003,
		"name" :  "amulet",
		"description": "Reduces the current health (-9), increases the max health (+1). It is not consumed when using",
		"icon" :"res://Assets/amulet.png",
		"usable" : true,
		"unlimited" : true,
	}
	itemList["alarm_potion"] = {
		"id" : 0004,
		"name" :  "alarm_potion",
		"description": "Locks all open houses on the street",
		"icon" : "res://Assets/alarm_potion.png",
		"usable" : true,
		"unlimited" : false,
	}
	itemList["key"] = {
		"id" : 0005,
		"name" :  "key",
		"description": "",
		"icon" : "res://Assets/key.png",
		"usable" : false,
		"unlimited" : false,
	}
	itemList["orange"] = {
		"id" : 0006,
		"name" :  "orange",
		"description": "Are apl. restore +1 hp",
		"icon" : "res://Assets/orange.png",
		"usable" : true,
		"unlimited" : false,
	}
	itemList["teleport_potion"] = {
		"id" : 0007,
		"name" :  "teleport_potion",
		"description": "Teleports the player in a random direction for a certain distance",
		"icon" : "res://Assets/teleport_potion.png",
		"usable" : true,
		"unlimited" : false,
	}
	itemList["token"] = {
		"id" : 0008,
		"name" :  "token",
		"description": "A round piece of metal with the number 14. Cannot be used",
		"icon" : "res://Assets/token.png",
		"usable" : false,
		"unlimited" : false,
	}
	itemList["oliver"] = {
		"id" : 0009,
		"name" :  "oliver",
		"description": "Reduces the current Max health (-10)",
		"icon" : "res://Assets/oliver.png",
		"usable" : true,
		"unlimited" : false,
	}
	
	pass

func inventorySort():
	for i in range (inventory.size()-1):
		if inventory[i] == null && Global.inventory[i + 1] != null:
			inventory[i] = Global.inventory[i + 1]
			inventory[i + 1] = null
			inventorySort()

func inventoryDrop():
	var scene = get_node("/root/Street")


func use(itemName):
	var scene = get_node("/root/Street")
	
	match itemName:
		null:
			pass
		"apple":
			appleFunc()
		"chili":
			chiliFunc()
		"amulet":
			amuletFunc()
		"alarm_potion":
			alarm_potionFunc()
		"key":
			pass
		"orange":
			orange_Func()
		"teleport_potion":
			teleport_potionFunc()
		"token":
			tokenFunc()
		"olives":
			olivesFunc()

func appleFunc():
	health += 1

func chiliFunc():
	health -= 1

func amuletFunc():
	health -= 9
	healthMax += 1

func alarm_potionFunc():
	var house = get_node("/root/Street/House")
	house.locFunc()
	pass
	
func orange_Func():
	health += 1
	healthMax += 1

func teleport_potionFunc():
	var player = get_node("/root/Street/Player")
	var tp = get_node("/root/Street/TP")
	var limits = [100, 100, 650, 300]
	while true:
		tp.position.x = randi_range(limits[0], limits[2])
		tp.position.y = randi_range(limits[1], limits[3])
		if tp.bodys == false:
			player.position = tp.position
			player.get_node("Interface/Inventory").queue_free()
			get_tree().paused = false
			break
		else:
			tp.bodys = false
		
	pass

func tokenFunc():
	
	pass

func olivesFunc():
	healthMax -=10

func save_game():
	var save_game = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("GroupStreet")
	for node in save_nodes:

		var node_data = node.call("save")
		var json_string = JSON.stringify(node_data)
		save_game.store_line(json_string)


	
