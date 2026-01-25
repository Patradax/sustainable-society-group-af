extends Node2D

@onready var movingtrash = preload("res://rivertrash resources/rivertrash.tscn")
@onready var spawn_timer = Timer.new()

func _ready() -> void:
	Global.reset_game()
	add_child(spawn_timer)
	spawn_timer.wait_time = 1.5 
	spawn_timer.timeout.connect(spawn_trash)
	spawn_timer.start()

func get_random_point_in_area() -> Vector2:
	return Vector2(-100, randf_range(250, 700))

func spawn_trash():
	var rivertrash = movingtrash.instantiate()
	rivertrash.global_position = get_random_point_in_area()
	add_child(rivertrash)

func _process(_delta):
	# Win condition
	if Global.sustainability_score >= 100:
		Global.reset_game()
		get_tree().change_scene_to_file("res://game_menu.tscn")

# --- QUIT LOGIC ---
func _on_quit_button_pressed() -> void:
	var dialog = find_child("QuitDialog")
	if dialog:
		dialog.dialog_text = "Score: " + str(Global.sustainability_score) + "\nQuit to Menu?"
		dialog.popup_centered()
		get_tree().paused = true

func _on_quit_dialog_confirmed() -> void:
	Global.reset_game()
	get_tree().change_scene_to_file("res://game_menu.tscn")

func _on_quit_dialog_canceled() -> void:
	get_tree().paused = false
