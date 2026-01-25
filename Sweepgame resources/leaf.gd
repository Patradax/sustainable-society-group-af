extends CharacterBody2D

var knockback : Vector2 = Vector2.ZERO
var knockback_timer : float = 0

func _physics_process(delta: float) -> void:
	if knockback_timer > 0.0:
		velocity = knockback
		knockback_timer -= delta
	else:
		# Friction: leaf slows down naturally
		velocity = lerp(velocity, Vector2.ZERO, 5 * delta)
	
	move_and_slide()

func apply_knockback(direction: Vector2, force: float, duration: float) -> void:
	knockback = direction * force
	knockback_timer = duration
