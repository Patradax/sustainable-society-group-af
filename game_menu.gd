extends Control

func _on_river_button_pressed() -> void:
	print("Going to River Game")
	get_tree().change_scene_to_file("res://rivertrash resources/rivergame.tscn")

func _on_tree_button_pressed() -> void:
	print("Going to Tree Game")
	get_tree().change_scene_to_file("res://Sweepgame resources/sweepgame.tscn")

func _on_trash_sort_button_pressed() -> void:
	print("Going to Trash Sorting")
	get_tree().change_scene_to_file("res://trashsortgame resources/trashsortgame.tscn")

# Back to Main Menu Button
func _on_back_to_menu_pressed() -> void:
	print("1. Back Button clicked")
	Global.reset_game()
	
	get_tree().change_scene_to_file("res://main_menu.tscn")
