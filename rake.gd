extends CharacterBody2D

var is_grabbed : bool = false

func _process(delta: float) -> void:
	if is_grabbed: # makes rake follow mouse when grabbed
		var mouse_pos = get_global_mouse_position()
		global_position = lerp(global_position, mouse_pos, 20 * delta)
		return

func _on_area_2d_body_entered(body: Node2D) -> void:
	# checks if colliding with leaf before doing anything
	if body.is_in_group("leaf"):
		var knockback_direction = (body.global_position - global_position).normalized()
		body.apply_knockback(knockback_direction, 100, 0.12)
		print(knockback_direction)


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			is_grabbed = true
			print("I've been grabbed")
		else:
			is_grabbed = false
			print("I've been let go")


# references
# for drag and drop system
# https://www.youtube.com/watch?v=5OryPrQMX1Y
# for sweep(knockback) system
# https://www.youtube.com/watch?v=ksLKc9oACQA
# for why rake detects input outside of itself (bug fixed, see input_pickable in godot docs)
# https://www.youtube.com/watch?v=UZ2Da4O20sU&t=339s (at 5.42)
