extends CharacterBody2D

var time: float = 0.0
var frequency: float = 2.0 # How many waves per second
var amplitude: float = 50.0 # Pixels high the wave is
var move_speed: float = 100.0 # Pixels per second horizontally

func _process(delta: float) -> void:
	# Update time for smooth, time-based animation
	time += delta * frequency # Multiply by frequency to control wave speed

	# Calculate the vertical offset using sine
	var sine_offset = sin(time) * amplitude

	# Move horizontally and apply vertical offset
	position.x += move_speed * delta
	position.y = starting_y_position + sine_offset # Use a stored starting Y

# You'll need to store the initial Y position
var starting_y_position: float
func _ready():
	starting_y_position = position.y
