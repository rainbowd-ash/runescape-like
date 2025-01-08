extends CharacterBody3D

@export var speed = 4.0  # Movement speed
@export var rotation_speed = 5.0  # Turning speed

var target_position: Vector3 = Vector3.ZERO
var moving = false

func _physics_process(delta):
	if moving:
		# Calculate direction to target
		var direction = (target_position - global_transform.origin)
		if direction.length() > 0.1:  # Keep moving if far enough from target
			direction = direction.normalized()
			velocity = direction * speed
			
			# Rotate to face the target
			var target_rotation_y = atan2(direction.x, direction.z)  # Rotation around Y-axis
			rotation.y = lerp_angle(rotation.y, target_rotation_y, rotation_speed * delta)
		else:
			velocity = Vector3.ZERO
			moving = false

	move_and_slide()

func set_target_position(position: Vector3):
	# Snap the target position to the nearest 1-meter grid
	target_position = snap_to_grid(position)
	moving = true

func snap_to_grid(position: Vector3) -> Vector3:
	# Snap position to the nearest grid point
	return Vector3(
		round(position.x),
		round(position.y),
		round(position.z)
	)
