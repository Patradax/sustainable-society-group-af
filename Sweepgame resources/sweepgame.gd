extends Node2D

# --- NODES & SCENES ---
@onready var leaf_scene = preload("res://Sweepgame resources/leaf.tscn")
@onready var game_over_popup = $CanvasLayer/GameOverPopup
@onready var final_score_label = $CanvasLayer/GameOverPopup/FinalScoreLabel
@onready var win_popup = $CanvasLayer/WinPopup
@onready var win_score_label = $CanvasLayer/WinPopup/WinScoreLabel

func _ready():
	# 1. Clean up any accidental editor leaves
	for old_leaf in get_tree().get_nodes_in_group("leaf"):
		old_leaf.queue_free()
		
	Global.reset_game()
	# Set this back to 15 once you confirm the 1-leaf test works!
	spawn_all_leaves(15) 

func _process(_delta):
	# Only show Game Over if the player hasn't already won
	if Global.time_left <= 0 and not win_popup.visible and not game_over_popup.visible:
		show_game_over()

# --- LEAF SPAWNING ---

func spawn_all_leaves(count: int):
	var spawn_points = get_tree().get_nodes_in_group("TreeSpawn")
	for i in range(count):
		var leaf = leaf_scene.instantiate()
		
		if spawn_points.size() > 0:
			var random_marker = spawn_points.pick_random()
			var offset = Vector2(randf_range(-120, 120), randf_range(-120, 120))
			leaf.global_position = random_marker.global_position + offset
		else:
			leaf.global_position = Vector2(randf_range(200, 900), randf_range(200, 500))
		
		leaf.rotation = randf_range(0, TAU)
		
		# Add to group so the win condition can count it
		leaf.add_to_group("leaf")
		add_child(leaf)

# --- GAMEPLAY LOGIC ---

func _on_compost_bin_body_entered(body: Node2D) -> void:
	if body.is_in_group("leaf"):
		var leaf_pos = body.global_position
		
		# 1. Remove the group name immediately so it's not counted in the win check
		body.remove_from_group("leaf") 
		body.queue_free()
		
		Global.add_score(10)
		spawn_score_popup(leaf_pos)
		
		# 2. Check if that was the last leaf
		check_win_condition()

func spawn_score_popup(pos: Vector2):
	var popup_scene = preload("res://score_popup.tscn")
	if popup_scene:
		var popup = popup_scene.instantiate()
		popup.global_position = pos
		$CanvasLayer.add_child(popup)

func check_win_condition():
	# If we already showed a popup, stop checking
	if win_popup.visible or game_over_popup.visible: 
		return
	
	var leaves_left = get_tree().get_nodes_in_group("leaf").size()
	print("Leaves remaining: ", leaves_left)
	
	if leaves_left == 0:
		win_level()

func win_level():
	print("WIN TRIGGERED")
	get_tree().paused = true
	win_popup.visible = true
	# Safety check for label path
	if win_score_label:
		win_score_label.text = "Final Score: " + str(Global.sustainability_score)

func show_game_over():
	print("GAME OVER TRIGGERED")
	get_tree().paused = true
	game_over_popup.visible = true
	if final_score_label:
		final_score_label.text = "Leaves Collected: " + str(Global.sustainability_score)

# --- UI BUTTONS ---

func _on_continue_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://game_menu.tscn")

func _on_restart_pressed() -> void:
	get_tree().paused = false
	Global.reset_game()
	get_tree().reload_current_scene() 

func _on_exit_pressed() -> void:
	get_tree().paused = false
	Global.reset_game()
	get_tree().change_scene_to_file("res://game_menu.tscn")

# --- QUIT DIALOG ---

func _on_quit_button_pressed() -> void:
	var dialog = find_child("QuitDialog")
	if dialog:
		dialog.process_mode = Node.PROCESS_MODE_ALWAYS
		dialog.dialog_text = "Current Score: " + str(Global.sustainability_score) + "\nAre you sure you want to return to the park?"
		dialog.popup_centered()
		get_tree().paused = true

func _on_quit_dialog_confirmed() -> void:
	get_tree().paused = false 
	Global.reset_game()
	get_tree().change_scene_to_file("res://game_menu.tscn")

func _on_quit_dialog_canceled() -> void:
	get_tree().paused = false
