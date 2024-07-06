extends CharacterBody2D

signal laser(pos, direction)
signal grenade(pos, direction)

@export var max_speed: int = 500
var speed: int = max_speed

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
	Globals.player_pos = self.position
	
	# rotate to mouse
	self.look_at(get_global_mouse_position())
	
	# shoot laser input
	if Input.is_action_pressed("primary action") and can_laser and Globals.laser_amount > 0:
		Globals.laser_amount -= 1
		var selected_laser = laser_markers[randi() % laser_markers_size]
		var facing_direction = (get_global_mouse_position() - self.position).normalized()
		can_laser = false
		$LaserTimer.start()
		$GPUParticles2D.emitting = true
		laser.emit(selected_laser.global_position, facing_direction)
	
	# shoot grenade input
	if Input.is_action_pressed("secondary action") and can_grenade and Globals.grenade_amount > 0:
		Globals.grenade_amount -= 1
		var selected_grenade = laser_markers[randi() % laser_markers_size]
		var facing_direction = (get_global_mouse_position() - self.position).normalized()
		can_grenade = false
		$GrenadeTimer.start()
		grenade.emit(selected_grenade.global_position, facing_direction)

func _on_laser_timer_timeout() -> void:
	can_laser = true

func _on_grenade_timer_timeout() -> void:
	can_grenade = true
