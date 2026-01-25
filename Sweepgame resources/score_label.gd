extends Label

func _process(_delta):
	# This pulls the score from your Global script every frame
	text = "Score: " + str(Global.sustainability_score)
