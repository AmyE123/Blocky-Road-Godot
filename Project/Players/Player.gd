extends KinematicBody

enum Side {UP, DOWN}

export var fall_acceleration = 1
export var is_moving = false
export var number_of_spaces = 2
export var player_color = Color(1, 0, 0)
export var player_side = Side.UP
export var current_level_side = Side.UP

export var completed_level = false
var velocity = Vector3.ZERO
var is_rotating


func _ready():
	#Set the players material color
	var material = $Pivot/Character.material
	material.albedo_color = player_color


func _physics_process(delta):
	current_level_side = get_parent().get_parent().get("level_side")
	is_rotating = get_parent().get("is_rotating")
	
	if(player_side != current_level_side):
		$Pivot/Character.set_physics_process(false)
	else:
		if(!is_rotating):
			$Pivot/Character.set_physics_process(true)
			velocity.y -= fall_acceleration * delta
			velocity = move_and_slide(velocity, Vector3.UP)
	
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if(collision.collider.is_in_group("win_block") && completed_level != true):
			get_parent().get_parent().get("num_completed_players") + 1
			completed_level = true
			print("Win")
		

func _input(event):
	if(is_moving == false):
		if(player_side == current_level_side):
			if(event.is_action_pressed("move_right")):
				translate_object_local(Vector3.RIGHT * number_of_spaces)
			if(event.is_action_pressed("move_left")):
				translate_object_local(Vector3.LEFT * number_of_spaces)
