extends Area2D

enum binchoice {trash, recycle}
@export var bin_type : binchoice

func _ready() -> void: #colour codes and gives the bin their category
	if bin_type == binchoice.recycle:
		print("recycling")
		$Sprite2D.modulate = Color.GREEN
	elif bin_type == binchoice.trash:
		print("trash")
		$Sprite2D.modulate = Color.BLACK
	
