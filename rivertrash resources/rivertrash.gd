extends CharacterBody2D

@onready var endpoint = $"../Area2D"


var freq = 20 # frequency of bounces (going up and down)
var amp = 150 # range of bounces (going up and down)
var time = 0 # consider as x axis in function
var speed = 100 # speed of going to right
var health = 5 #amount of clicks before it goes away

func _ready() -> void:
	freq = randi_range(10,20)
	amp = randi_range(100, 500)
	speed = randi_range(100, 500)
	pass

func _physics_process(delta: float) -> void:
	if health >0:
		time += delta
		var movement = cos(time * freq) * amp
		position.y += movement * delta
		position.x += speed * delta 
	else:
		print("dies") # kills the trash
		get_parent().update_score(50)
		queue_free()


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		health -= 1 
