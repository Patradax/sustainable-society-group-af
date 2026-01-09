extends RigidBody2D

var strength : float = 10

var held = false

func _integrate_forces(_state: PhysicsDirectBodyState2D) -> void:
	if held:
		linear_velocity = global_position.direction_to(get_global_mouse_position()) * (global_position.distance_to(get_global_mouse_position()) * strength) 


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			held = true
			print(held)
		else:
			held = false
			print(held)
