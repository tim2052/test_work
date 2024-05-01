extends Node


func use(itemName):
	var parent = get_parent()
	while parent:
		if parent.get_parent().get_parent() is Node:
			parent = parent.get_parent()
		else:
			break
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
			

func appleFunc():
	Global.health += 1

func chiliFunc():
	Global.health -= 1

func amuletFunc():
	Global.health -= 9
	Global.healthMax += 1

func alarm_potionFunc():
	
	pass
	
func orange_Func():
	Global.health += 1
	Global.healthMax += 1

func teleport_potionFunc():
	
	pass

func tokenFunc():
	
	pass
