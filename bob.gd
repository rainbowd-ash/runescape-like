extends CharacterBody3D

@export var speed = 4.0

var target_position: Vector3 = Vector3.ZERO
var moving = false

func _physics_process(delta):
	if moving:
		var direction = (target_position - global_transform.origin).normalized()
		velocity = direction * speed
		if global_transform.origin.distance_to(target_position) < 0.1:
			velocity = Vector3.ZERO
			moving = false
		move_and_slide()

func set_target_position(position: Vector3):
	target_position = position
	moving = true
