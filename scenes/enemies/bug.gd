extends CharacterBody2D

var player_detected: bool = false
var player_attackable: bool = false
var can_attack: bool = true
var vulnerable: bool = true

@export var movement_speed: int = 400
@export var health: int = 30

var player: Node2D

func _process(_delta):
	if player_detected:
		self.look_at(Globals.player_pos)
		var direction: Vector2 = (Globals.player_pos - self.position).normalized()
		self.velocity = direction * movement_speed
		self.move_and_slide()

func take_damage(damage):
	if vulnerable:
		health -= damage
		vulnerable = false
		$Timers/VulnerableTimer.start()
		$AnimatedSprite2D.material.set_shader_parameter("progress",0.8)
		$HitParticles.emitting = true
		if health <= 0:
			await get_tree().create_timer(0.3).timeout
			self.queue_free()

func _on_notice_area_body_entered(_body: Node2D) -> void:
	player_detected = true
	$AnimatedSprite2D.play("walk")

func _on_notice_area_body_exited(_body: Node2D) -> void:
	player_detected = false
	$AnimatedSprite2D.stop()

func _on_attack_area_body_entered(body: Node2D) -> void:
	player_attackable = true
	$AnimatedSprite2D.play("attack")
	player = body

func _on_attack_area_body_exited(_body: Node2D) -> void:
	player_attackable = false

func _on_attack_timer_timeout() -> void:
	can_attack = true
	$AnimatedSprite2D.play("attack")

func _on_animated_sprite_2d_animation_finished() -> void:
	if can_attack and player_attackable and "take_damage" in player:
		player.take_damage(10)
		can_attack = false
		$Timers/AttackTimer.start()

func _on_vulnerable_timer_timeout() -> void:
	vulnerable = true
	$AnimatedSprite2D.material.set_shader_parameter("progress",0)
