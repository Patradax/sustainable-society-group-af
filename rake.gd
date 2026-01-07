extends CharacterBody2D

var is_grabbed : bool = false

func _process(delta: float) -> void:
	if is_grabbed:
		var mouse_pos = get_global_mouse_position()
		global_position = lerp(global_position, mouse_pos, 20 * delta)
		return

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			is_grabbed = true



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("leaf"):
		var knockback_direction = (body.global_position - global_position).normalized()
		body.apply_knockback(knockback_direction, 150, 0.12)
		print(knockback_direction)
	pass # Replace with function body.
