extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var is_jumping = false
var prev_position = position
var iteration = 0
var force = 50 
var jumps = 0
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
	#print(is_jumping, position, iteration)
	iteration += 1
	$Line2D.visible = false
	
	$Line2D.set_point_position(0, get_transform().affine_inverse() * get_global_mouse_position())
	if Input.is_action_pressed("ui_accept") and not is_jumping:
		#print("jump")
		#add_force(Vector2(0,0), Vector2(0,-500))
		#apply_impulse(Vector2(0,0), Vector2(0,-500))
		var offset = Vector2.ZERO
		var target = get_global_mouse_position() - position
		target = target.normalized()
		if force <= 500:
			force += 2
		print(force)
		$Line2D.visible = true
		
	if Input.is_action_just_released("ui_accept"):
		var offset = Vector2.ZERO
		var target = get_global_mouse_position() - position
		target = target.normalized()
		apply_impulse(offset, target*force)
		force = 50
		$Line2D.visible = false

		
