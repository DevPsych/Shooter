extends CharacterBody2D

var speed: float = 500
var can_laser: bool = true
var can_grenade: bool = true
signal laser
signal grenade

func _process(_delta: float) -> void:
	
	# movement input
	var direction: Vector2 = Input.get_vector("left", "right","up","down")
	self.velocity = direction * speed
	self.move_and_slide()
	
	# shoot laser input
	if Input.is_action_pressed("primary action") and can_laser:
		can_laser = false
		$LaserTimer.start()
		laser.emit()
	
	# shoot grenade input
	if Input.is_action_pressed("secondary action") and can_grenade:
		can_grenade = false
		$GrenadeTimer.start()
		grenade.emit()


func _on_laser_timer_timeout() -> void:
	can_laser = true


func _on_grenade_timer_timeout() -> void:
	can_grenade = true
