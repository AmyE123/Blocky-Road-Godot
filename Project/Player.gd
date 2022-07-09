extends KinematicBody

enum Side {BLUE, RED}

export var fall_acceleration = 100
export var is_moving = false
export var number_of_spaces = 2
export var player_color = Color(1, 0, 0)
export var player_side = Side.BLUE
export var current_level_side = Side.BLUE

var velocity = Vector3.ZERO

func _ready():
	#Set the players material color
	var material = $Pivot/Character.material
	material.albedo_color = player_color


func _physics_process(delta):
	current_level_side = get_parent().get("level_side")
	
	if(player_side == Side.BLUE):
		velocity.y -= fall_acceleration * delta
		velocity = move_and_slide(velocity, Vector3.UP)
		
		if(velocity.y <= -10):
			print("Fall")			
	
	if(player_side == Side.RED):
		velocity.y += fall_acceleration * delta
		velocity = move_and_slide(velocity, Vector3.DOWN)
		
		if(velocity.y >= 10):
			print("Fall")
			
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if(collision.collider.is_in_group("win_block")):
			print("Collided")
		

func _input(event):
	if(is_moving == false):
		if(player_side == current_level_side):
			if(event.is_action_pressed("move_right")):
				translate_object_local(Vector3.RIGHT * number_of_spaces)
			if(event.is_action_pressed("move_left")):
				translate_object_local(Vector3.LEFT * number_of_spaces)
