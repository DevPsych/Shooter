extends Node2D

var speed: float = 500

func _process(delta: float) -> void:
	
	# movement input
	var direction: Vector2 = Input.get_vector("left", "right","up","down")
	self.position += direction * speed * delta
	
	# shoot laser input
	if Input.is_action_pressed("primary action"):
		print("shoot laser")
		$"..".rotate_logo()
	
	# shoot gernade input
	if Input.is_action_pressed("secondary action"):
		print("shoot gernade")
