extends CharacterBody2D

var player_nearby: bool = false
var can_laser: bool = true
var can_shoot_right_laser: bool = true
var vulnerable: bool = true

var health: int = 30

signal laser(pos, direction)

func _process(_delta: float) -> void:
	if player_nearby:
		self.look_at(Globals.player_pos)
		if can_laser:
			var marker_node = $LaserSpawnPosition.get_child(can_shoot_right_laser)
			can_shoot_right_laser = not can_shoot_right_laser
			var pos: Vector2 = marker_node.global_position
			var direction: Vector2 = (Globals.player_pos - self.position).normalized()
			laser.emit(pos, direction)
			can_laser = false
			$Timers/LaserTimer.start()

func _on_attack_area_body_entered(_body: Node2D) -> void:
	player_nearby = true

func _on_attack_area_body_exited(_body: Node2D) -> void:
	player_nearby = false

func take_damage(damage):
	if vulnerable:
		health -= damage
		$AudioStreamPlayer2D.play()
		vulnerable = false
		$Sprite2D.material.set_shader_parameter("progress", 0.8)
		$Timers/VulnerableTimer.start()
		if health <= 0:
			self.queue_free()

func _on_laser_timer_timeout() -> void:
	can_laser = true

func _on_vulnerable_timer_timeout() -> void:
	vulnerable = true
	$Sprite2D.material.set_shader_parameter("progress", 0)
