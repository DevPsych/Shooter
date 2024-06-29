extends CharacterBody2D

var speed: float = 500

func _process(_delta: float) -> void:
	
	# movement input
	var direction: Vector2 = Input.get_vector("left", "right","up","down")
	self.velocity = direction * speed
	self.move_and_slide()
	
	# shoot laser input
	if Input.is_action_pressed("primary action"):
		print("shoot laser")
	
	# shoot gernade input
	if Input.is_action_pressed("secondary action"):
		print("shoot gernade")
