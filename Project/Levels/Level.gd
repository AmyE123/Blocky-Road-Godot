extends Node
enum Side {BLUE, RED}
export var level_side = Side.BLUE
export var rotate_toggle = false
export var rotating = false

var z_rot = -180
var completed_level = false
export var num_completed_players = 0

func _physics_process(delta):
	if(rotate_toggle):
		_lerp_rotate_obj(z_rot, delta, $Pivot)
	else:
		_lerp_rotate_obj(0, delta, $Pivot)
	
	if(num_completed_players == 2):
		completed_level = true
		if(completed_level):
			print("WIN")

func _input(event):
	if(event.is_action_pressed("flip_map")):
		rotate_toggle = !rotate_toggle
		level_side = Side.RED if level_side == Side.BLUE else Side.BLUE

func _lerp_rotate_obj(degree, delta, object):
	object.rotation.z = lerp_angle($Pivot.rotation.z, deg2rad(degree), 20 * delta)
