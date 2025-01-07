extends CharacterBody3D

@export var speed = 4.0
@export var rotation_speed = 5.0

var target_position: Vector3 = Vector3.ZERO
var moving = false

func _physics_process(delta):
	if moving:
		var direction = (target_position - global_transform.origin)
		if direction.length() > 0.1:  # Keep moving if not close enough
			direction = direction.normalized()
			velocity = direction * speed
			
			var target_rotation = global_transform.basis.get_euler()
			target_rotation.y = atan2(direction.x, direction.z)  # Rotate around the Y-axis
			
			rotation.y = lerp_angle(rotation.y, target_rotation.y, rotation_speed * delta)
		else:
			velocity = Vector3.ZERO
			moving = false
	
	move_and_slide()

func set_target_position(position: Vector3):
	target_position = position
	moving = true
