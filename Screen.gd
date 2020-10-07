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
var diceIndex = 0

var speedMax = 0.1
var speedCur = 0

var selected_dice


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
	dice_new.name = "Dice" + str(diceIndex)
	diceIndex += 1
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
	
func _input(event):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and not event.is_pressed():
		print("Mouse Click/Unclick at: ", event.position)
		dice = is_dice_under_mouse(event.position)
		print(dice)
		if dice != null:
			selected_dice = dice
			return
		if selected_dice == null:
			return
		# TODO selected_dice move to event.position
		# ...

func is_dice_under_mouse(position):
	print("Local: " + str(to_local(position)))
	var children = self.get_children()
	#var dices = [d for d in self.get_children() if isinstance(d, Sprite)]
	for child in children:
		if !(child is Sprite):
			continue
		#print("Rect" + str(child.get_rect()))
		var rect = Rect2(child.position, Vector2(dice_width, dice_height))
		#if child.get_rect().has_point(to_local(position)):
		if rect.has_point(to_local(position)):
			print("Rect" + str(rect))
			print("Dice with name '" + child.name + "' is selected")
			return child
	return null
