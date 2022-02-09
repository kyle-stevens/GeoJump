extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var is_jumping = false
var prev_position = position
var iteration = 0

var jumps = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if prev_position != position:
	if abs(prev_position.x - position.x) > 0.09 or abs(prev_position.y - position.y) > 0.09:
		is_jumping = true
		pass
	else:
		is_jumping = false
		#$Line2D.visible = true
	prev_position = position
	#print(is_jumping, $Line2D.visible)
	iteration += 1
	$Line2D.visible = false
	
	$Line2D.set_point_position(0, get_transform().affine_inverse() * get_global_mouse_position())
	if Input.is_action_pressed("ui_accept") and not is_jumping:
		$Line2D.visible = true
		pass
		
	if Input.is_action_just_released("ui_accept") and not is_jumping:
		var offset = Vector2.ZERO
		var target = get_global_mouse_position() - position
		apply_impulse(offset, target*3)
		$Line2D.visible = false


func death():
	pass
	#respawn
	var pos = get_parent().get_node("spawn_position")
	print(pos)
	
	var scene = load("res://Player_cube_demo.tscn")
	var instance = scene.instance()
	instance.global_transform.origin = pos.global_transform.origin
	get_parent().add_child(instance)
	queue_free()
	#position = pos.global_transform.origin
	
		





func _on_Area2D_body_entered(body):
	death()
	print("dead")
