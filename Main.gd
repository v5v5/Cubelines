extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

onready var sprite = get_node("Sprite")
onready var is_process = get_node("CheckBox")

var speedMax = 0.5
var speedCur = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not is_process.pressed:
		return
	speedCur -= delta
	if speedCur < 0:
		var i = sprite.frame
		i += 1
		if i == sprite.hframes - 1:
			i = 0
		sprite.frame = i
		speedCur = speedMax
