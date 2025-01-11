extends Node3D

@export var camera : Node3D
@export var player : Node3D

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var space_state = get_world_3d().direct_space_state
		var mousepos = get_viewport().get_mouse_position()
		
		var ray_origin = camera.project_ray_origin(event.position)
		var ray_end = ray_origin + camera.project_ray_normal(mousepos) * 100
		
		var query = PhysicsRayQueryParameters3D.create(ray_origin, ray_end)
		query.collide_with_areas = true
		query.exclude = [player]
		var result = space_state.intersect_ray(query)
		
		if result:
			var movement_details = {
				target_position = result.position
			}
			if result.collider.is_in_group("interactables"):
				movement_details.target_interactable = result.collider
			player.set_movement_target(movement_details)
