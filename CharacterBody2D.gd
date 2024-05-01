extends CharacterBody2D

@onready var playerSprite = {
	"up" : load("res://Assets/player_anim_up.png"),
	"down" : load("res://Assets/player_anim_down.png"),
	"left" : load("res://Assets/player_anim_left.png"),
	"right" : load("res://Assets/player_anim_right.png")
}
const SPEED = 100.0

var restartVar = false

func _ready():
	$Timer.start()
	pass
	
func _physics_process(delta):
	if Global.health <= 0:
		if restartVar == false:
			$Interface/CV/CC.visible = true
			$GO.start()
			restartVar = true
	if Global.health > Global.healthMax:
		Global.health = Global.healthMax
	
	
	var direction = Input.get_axis("ui_left", "ui_right")
		
	if direction:
		if direction < 0 :
			$Sprite2D.texture = playerSprite["left"]
			if $Sprite2D.texture == playerSprite["left"]:
				$PLINT.rotation_degrees = 180
		else:
			$Sprite2D.texture = playerSprite["right"]
			if $Sprite2D.texture == playerSprite["right"]:
				$PLINT.rotation_degrees = 0

		velocity.x = direction * SPEED
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	direction = Input.get_axis("ui_down", "ui_up")
	if direction:
		if direction < 0 :
			$Sprite2D.texture = playerSprite["down"]
			if $Sprite2D.texture == playerSprite["down"]:
				$PLINT.rotation_degrees = -270
		else:
			$Sprite2D.texture = playerSprite["up"]
			if $Sprite2D.texture == playerSprite["up"]:
				$PLINT.rotation_degrees = -90
		velocity.y = -direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	move_and_slide()


func _on_go_timeout():
	restartVar = false
	Global.health = 10
	Global.healthMax = 10
	Global.save = false
	Global.inventory = [null,null,null,null,null,null,null,null,null]
	get_tree().change_scene_to_file("res://Scenes/main/street.tscn")
	pass # Replace with function body.

func save():
	var save_dict = {
		"name" : name,
		"filename" : get_scene_file_path(),
		"fileInScene": get_path(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x, 
		"pos_y" : position.y,
	}
	return save_dict


 # Replace with function body.


func _on_timer_timeout():
	name = "Player"
	pass # Replace with function body.
