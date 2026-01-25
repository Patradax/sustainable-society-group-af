extends Node

var sustainability_score : int = 0
var time_left : float = 70.0 

func _process(delta):
	var current_scene = get_tree().current_scene
	if current_scene == null: return
	
	# The timer ONLY runs if we are NOT in a menu
	# Make sure your Main Menu root node is named "main_menu"
	# Make sure your Game Menu root node is named "game_menu"
	if current_scene.name != "main_menu" and current_scene.name != "game_menu":
		if time_left > 0:
			time_left -= delta
		else:
			print("Time up! Returning to Game Menu")
			reset_game()
			get_tree().change_scene_to_file("res://game_menu.tscn")

func add_score(amount):
	sustainability_score += amount
	print("Score is now: ", sustainability_score)

func reset_game():
	sustainability_score = 0
	time_left = 70.0
	get_tree().paused = false
