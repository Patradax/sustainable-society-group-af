extends Node2D

@onready var leaf_scene = preload("res://leaf.tscn")

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("A"):
		spawn_leaf()

func spawn_leaf():
	var leaf = leaf_scene.instantiate()
	leaf.global_position = get_global_mouse_position()
	add_child(leaf)
