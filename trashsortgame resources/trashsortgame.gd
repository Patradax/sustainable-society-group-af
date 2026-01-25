extends Node2D

@onready var trash_scene = preload("res://trashsortgame resources/trash.tscn")
var spawn_center = Vector2(576, 324) 

func _ready() -> void:
	Global.reset_game()
	spawn_trash_at_center()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("A"):
		spawn_trash_at_center()

func spawn_trash_at_center():
	var trash = trash_scene.instantiate()
	trash.global_position = spawn_center
	trash.add_to_group("trash_items")
	add_child(trash)

func _on_trashcan_body_entered(body: Node2D) -> void:
	if body.is_in_group("trash_items"):
		if body.trashtype == $trashcan.bin_type:
			Global.add_score(15) 
			body.queue_free()
			spawn_trash_at_center() 
		else:
			Global.add_score(-5) 
			body.global_position = spawn_center 

func _on_recyclebin_body_entered(body: Node2D) -> void:
	if body.is_in_group("trash_items"):
		if body.trashtype == $recyclebin.bin_type:
			Global.add_score(15)
			body.queue_free()
			spawn_trash_at_center()
		else:
			Global.add_score(-5)
			body.global_position = spawn_center

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
