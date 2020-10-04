extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

onready var dice = get_node("Dice")
onready var is_process = get_node("CheckBox")

var speedMax = 0.5
var speedCur = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not is_process.pressed:
		return
	speedCur -= delta
	if speedCur < 0:
		var i = dice.frame
		i += 1
		if i == dice.hframes - 1:
			i = 0
		dice.frame = i
		speedCur = speedMax


func _on_Button_pressed():
	var diceNew = dice.duplicate()
	var offsetX = diceNew.texture.get_width() / diceNew.hframes * diceNew.scale.x
	var offsetY = diceNew.texture.get_height() / diceNew.vframes * diceNew.scale.y
	print('offsetX: ' + str(offsetX))
	print('offsetY: ' + str(offsetY))
	diceNew.translate(Vector2(offsetX,offsetY))
	self.add_child(diceNew)
