extends KinematicBody

export var fall_acceleration = 100

export var is_moving = false

export var number_of_spaces = 2

var velocity = Vector3.ZERO

func _physics_process(delta):
	var direction = Vector3.ZERO
	velocity.y -= fall_acceleration * delta
	velocity = move_and_slide(velocity, Vector3.UP)

func _input(event):
	if(is_moving == false):
		if(event.is_action_pressed("move_right")):
			translate_object_local(Vector3.RIGHT * number_of_spaces)
		if(event.is_action_pressed("move_left")):
			translate_object_local(Vector3.LEFT * number_of_spaces)
