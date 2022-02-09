extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var is_jumping = false
var prev_position = position
var iteration = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if prev_position != position:
		is_jumping = true
	else:
		is_jumping = false
	prev_position = position
	print(is_jumping, position, iteration)
	iteration += 1
	
	if Input.is_action_just_pressed("ui_accept") and not is_jumping:
		print("jump")
		#add_force(Vector2(0,0), Vector2(0,-500))
		#apply_impulse(Vector2(0,0), Vector2(0,-500))
		var offset = Vector2.ZERO
		var target = get_global_mouse_position() - position
		apply_impulse(offset, target)
