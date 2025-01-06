extends Node3D

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var space_state = get_world_3d().direct_space_state
		var cam = $Camera3D
		var mousepos = get_viewport().get_mouse_position()
		
		var ray_origin = cam.project_ray_origin(event.position)
		var ray_end = ray_origin + cam.project_ray_normal(mousepos) * 100
		
		var query = PhysicsRayQueryParameters3D.create(ray_origin, ray_end)
		query.collide_with_areas = true
		var result = space_state.intersect_ray(query)
		
		if result:
			$Bob.set_target_position(result.position)
