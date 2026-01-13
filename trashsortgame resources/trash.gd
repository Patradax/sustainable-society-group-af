extends CharacterBody2D

var dragging : bool = false
enum trashchoice {recycle, trash}
@export var trashtype : trashchoice


func _ready() -> void:
	var choice = randi_range(0,1)
	print(choice)
	if choice == 1:
		trashtype = trashchoice.recycle
		$Sprite2D.modulate = Color.SEA_GREEN
	elif choice == 0:
		trashtype = trashchoice.trash
		$Sprite2D.modulate = Color.DARK_VIOLET
	

func _physics_process(delta: float) -> void:
	move_and_slide()
	if dragging:
		var current_position : Vector2 = self.global_position
		var mouse_position : Vector2 = get_global_mouse_position()
		
		var distance : float = current_position.distance_to(mouse_position)
		var direction : Vector2 = current_position.direction_to(mouse_position)
		
		var speed : float = distance/delta
		
		velocity = direction * speed
	else:
		velocity.y += (3000 * delta)

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			dragging = true
		else:
			dragging = false
