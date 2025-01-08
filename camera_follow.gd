extends Node3D

@export var player_path: NodePath  # Drag the Player node here in the Inspector

func _process(delta):
	var player = get_node(player_path)
	# Follow the player's position
	global_transform.origin = player.global_transform.origin
	# Make the camera face the player while locking Y rotation
	#look_at(player.global_transform.origin, Vector3.UP)
