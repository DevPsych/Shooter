extends CharacterBody2D

signal laser(pos)
signal grenade(pos)

var speed: float = 500
var can_laser: bool = true
var can_grenade: bool = true

var laser_markers
var laser_markers_size

func _ready():
	laser_markers = $LaserStartPositions.get_children()
	laser_markers_size = laser_markers.size()

func _process(_delta: float) -> void:
	
	# movement input
	var direction: Vector2 = Input.get_vector("left", "right","up","down")
	self.velocity = direction * speed
	self.move_and_slide()
	
	# shoot laser input
	if Input.is_action_pressed("primary action") and can_laser:
		var selected_laser = laser_markers[randi() % laser_markers_size]
		can_laser = false
		$LaserTimer.start()
		laser.emit(selected_laser.global_position)
	
	# shoot grenade input
	if Input.is_action_pressed("secondary action") and can_grenade:
		var selected_grenade = laser_markers[randi() % laser_markers_size]
		can_grenade = false
		$GrenadeTimer.start()
		grenade.emit(selected_grenade.global_position)


func _on_laser_timer_timeout() -> void:
	can_laser = true


func _on_grenade_timer_timeout() -> void:
	can_grenade = true
