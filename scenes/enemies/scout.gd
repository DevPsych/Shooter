extends CharacterBody2D

var player_nearby: bool = false
var can_laser: bool = true
var can_shoot_right_laser: bool = true

signal laser(pos, direction)

func _process(_delta: float) -> void:
	if player_nearby:
		look_at(Globals.player_pos)
		if can_laser:
			var marker_node = $LaserSpawnPosition.get_child(can_shoot_right_laser)
			can_shoot_right_laser = not can_shoot_right_laser
			var pos: Vector2 = marker_node.global_position
			var direction: Vector2 = (Globals.player_pos - self.position).normalized()
			laser.emit(pos, direction)
			can_laser = false
			$Timer.start()

func _on_attack_area_body_entered(_body: Node2D) -> void:
	player_nearby = true

func _on_attack_area_body_exited(_body: Node2D) -> void:
	player_nearby = false

func _on_timer_timeout() -> void:
	can_laser = true

func take_damage():
	print("Scout damaged")
