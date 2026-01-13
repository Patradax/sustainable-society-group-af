extends Node2D

@onready var trash_scene = preload("res://trashsortgame resources/trash.tscn")

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("A"):
		spawn_trash()

func spawn_trash():
	var trash = trash_scene.instantiate() # spawns leaf at mouse position
	trash.global_position = get_global_mouse_position()
	add_child(trash)


func _on_trashcan_body_entered(body: Node2D) -> void:
	print("Something in trash can")
	if body.trashtype == $trashcan.bin_type:
		print("right bin")
	else:
		print("wrong fucking bin")

func _on_recyclebin_body_entered(body: Node2D) -> void:
	print("Something in recycle bin")
	if body.trashtype == $recyclebin.bin_type:
		print("right bin")
	else:
		print("wrong bin")
