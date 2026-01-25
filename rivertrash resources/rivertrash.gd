extends CharacterBody2D

var freq = 2.0  # Lowered for a smooth water wave effect
var amp = 50.0  # Range of the wave
var time = 0.0 
var speed = 150.0 
var health = 3   # Reduced health so player finishes faster

func _physics_process(delta: float) -> void:
	if health > 0:
		time += delta
		# Smooth sine wave movement
		var wave = cos(time * freq) * amp
		velocity.y = wave 
		velocity.x = speed
		move_and_slide()
		
		# If it goes off screen, delete it (failed to collect)
		if global_position.x > 1200: 
			queue_free()
	else:
		# Award points to Global score before disappearing
		if Global:
			Global.add_score(10)
		queue_free()

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		health -= 1
		# Visual feedback: flash red when hit
		modulate = Color.RED
		await get_tree().create_timer(0.1).timeout
		modulate = Color.WHITE
