extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var dice_origin = get_node("Dice")
onready var is_process = get_node("CheckBox")

var field_offset_x = 50
var field_offset_y = 200
var field_size_x = 10
var field_size_y = 10
var dice_width
var dice_height

var speedMax = 0.1
var speedCur = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	dice_width = dice_origin.texture.get_width() / dice_origin.hframes * dice_origin.scale.x
	dice_height = dice_origin.texture.get_height() / dice_origin.vframes * dice_origin.scale.y

	for x in range(field_size_x):
		for y in range(field_size_y):
			if fmod(x + y, 2) == 0:
				continue 
			var dice = duplicate_dice(dice_origin)
			move_dice(
				dice, 
				field_offset_x + dice_width * x, 
				field_offset_y + dice_height * y)

func duplicate_dice(dice_origin):
	var dice_new = dice_origin.duplicate()
	self.add_child(dice_new)
	return dice_new
	
func move_dice(dice, x, y):
	dice.position.x = x
	dice.position.y = y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not is_process.pressed:
		return
	speedCur -= delta
	if speedCur < 0:
		var i = dice_origin.frame
		i += 1
		if i == dice_origin.hframes - 1:
			i = 0
		dice_origin.frame = i
		speedCur = speedMax

func _on_Button_pressed():
	var dice_new = duplicate_dice(dice_origin)
	print('dice_width: ' + str(dice_width))
	print('dice_height: ' + str(dice_height))
	dice_new.translate(Vector2(dice_width, dice_height))
