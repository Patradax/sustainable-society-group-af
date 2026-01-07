extends CharacterBody2D

var knockback : Vector2 = Vector2.ZERO
var knockback_timer : float = 0

func _physics_process(delta: float) -> void:
	# controls physics of leaf in order to sweep
	if knockback_timer > 0.0:
		velocity = knockback
		knockback_timer -= delta
		if knockback_timer <= 0.0:
			knockback = Vector2.ZERO
	else:
		velocity = Vector2.ZERO # forces leaf to stop when no rake is no longer colliding
	move_and_slide()



func apply_knockback(direction: Vector2, force: float, knockback_duration: float) -> void:
	# applies knockback to leaf
	knockback = direction * force
	knockback_timer = knockback_duration
