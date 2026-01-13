extends Node2D

@onready var movingtrash = preload("res://rivertrash resources/rivertrash.tscn")

func get_random_point_in_area() -> Vector2:
	var min_x = -320
	var max_x = -64
	var min_y = 256
	var max_y = 768
	var random_x = randf_range(min_x, max_x)
	var random_y = randf_range(min_y, max_y)
	return Vector2(random_x, random_y)
	
func _ready() -> void:
	var coord = get_random_point_in_area()
	print(coord)

func spawn_trash():
	var spawn_coord = get_random_point_in_area()
	var rivertrash = movingtrash.instantiate()
	rivertrash.global_position = spawn_coord
	add_child(rivertrash)
	pass


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("A"):
		spawn_trash()
