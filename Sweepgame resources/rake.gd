extends CharacterBody2D

var is_grabbed : bool = false

func _process(delta: float) -> void:
	if is_grabbed:
		# Smoothing the movement so it feels like a heavy rake
		var mouse_pos = get_global_mouse_position()
		global_position = lerp(global_position, mouse_pos, 25 * delta)

func _input(event: InputEvent) -> void:
	# This detects the mouse release EVEN IF the mouse moved off the rake
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			# Check if we clicked ON the rake to start dragging
			# (Requires 'Input Pickable' to be ON in the Inspector)
			pass 
		else:
			is_grabbed = false

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			is_grabbed = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("leaf"):
		# Push the leaf away from the rake
		var direction = (body.global_position - global_position).normalized()
		body.apply_knockback(direction, 250, 0.15)


# references
# for drag and drop system
# https://www.youtube.com/watch?v=5OryPrQMX1Y
# for sweep(knockback) system
# https://www.youtube.com/watch?v=ksLKc9oACQA
# for why rake detects input outside of itself (bug fixed, see input_pickable in godot docs)
# https://www.youtube.com/watch?v=UZ2Da4O20sU&t=339s (at 5.42)
