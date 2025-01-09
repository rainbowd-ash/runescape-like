extends CharacterBody3D

@export var movement_speed : float = 4.0
@export var rotation_speed : float = 5.0

@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D

func _ready():

	# Make sure to not await during _ready.
	actor_setup.call_deferred()

func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame

func set_movement_target(movement_target: Vector3):
	navigation_agent.set_target_position(movement_target)

func _physics_process(delta):
	if navigation_agent.is_navigation_finished():
		return
	
	var destination = navigation_agent.get_next_path_position()
	var local_destination = destination - global_position
	var direction = local_destination.normalized()
	
	var target_rotation_y = atan2(direction.x, direction.z)  # Rotation around Y-axis
	rotation.y = lerp_angle(rotation.y, target_rotation_y, rotation_speed * delta)
	
	velocity = direction * movement_speed
	move_and_slide()
