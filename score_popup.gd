extends Label

func _ready():
	# 1. Start position (where it spawns)
	# 2. End position (move it up by 100 pixels)
	var target_pos = global_position + Vector2(0, -100)
	
	# Create a "Tween" (This handles the animation automatically)
	var tween = create_tween()
	
	# Make it move UP and fade OUT at the same time
	tween.set_parallel(true)
	
	# Animation 1: Move to target_pos over 1.0 seconds
	tween.tween_property(self, "global_position", target_pos, 1.0)
	
	# Animation 2: Change Alpha (transparency) to 0 over 1.0 seconds
	tween.tween_property(self, "modulate:a", 0.0, 1.0)
	
	# 3. When the animation is finished, delete the popup
	tween.chain().tween_callback(queue_free)
