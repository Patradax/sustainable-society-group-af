extends Node2D

var score : int = 0

@onready var score_text = $UI/score
@onready var movingtrash = preload("res://rivertrash resources/rivertrash.tscn")
@onready var timer = $Timer

func get_random_point_in_area() -> Vector2:  # randomly finds spot to spawn trash
	var min_x = -320
	var max_x = -64
	var min_y = 384
	var max_y = 640
	var random_x = randf_range(min_x, max_x)
	var random_y = randf_range(min_y, max_y)
	return Vector2(random_x, random_y)

func _ready() -> void:
	update_score(0) 
	timer.start()	
	pass

func spawn_trash():#teleports trash to coords upon spawn
	var spawn_coord = get_random_point_in_area()
	var rivertrash = movingtrash.instantiate()
	rivertrash.global_position = spawn_coord
	add_child(rivertrash)
	pass

func update_score(score_change):
	score += score_change
	score_text.text = "Score: " + str(score)

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("A"):
		spawn_trash()

func _on_timer_timeout() -> void:
	spawn_trash()
	timer.start()


func _on_area_2d_body_entered(body: Node2D) -> void:
	update_score(-10)
	body.queue_free()
