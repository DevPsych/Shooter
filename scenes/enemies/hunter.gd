extends CharacterBody2D

var player_detected: bool = false
var player_attackable: bool = false
var vulnerable: bool = true
var attackable_entities: Array
var speed: int = 300
var health: int = 100

func _ready():
	$NavigationAgent2D.path_desired_distance = 40.0
	$NavigationAgent2D.target_desired_distance = 40.0

func _physics_process(_delta: float) -> void:
	if player_detected:
		var next_path_pos: Vector2 = $NavigationAgent2D.get_next_path_position()
		var direction: Vector2 = (next_path_pos - self.global_position).normalized()
		self.velocity = direction * speed
		self.move_and_slide()
		var look_angle = direction.angle()
		self.rotation = look_angle + PI / 2
		if player_attackable:
			$AnimationPlayer.play("Attack")

func _on_notice_area_body_entered(_body: Node2D) -> void:
	player_detected = true
	$NavigationAgent2D.target_position = Globals.player_pos
	$AnimationPlayer.play("Move")

func _on_notice_area_body_exited(_body: Node2D) -> void:
	player_detected = false
	$AnimationPlayer.stop()

func _on_navigation_timer_timeout() -> void:
	if player_detected:
		$NavigationAgent2D.target_position = Globals.player_pos

func _on_attack_area_body_entered(body: Node2D) -> void:
	player_attackable = true
	attackable_entities.append(body)

func _on_attack_area_body_exited(body: Node2D) -> void:
	player_attackable = false
	attackable_entities.erase(body)

func attack():
	for entity in attackable_entities:
		if "take_damage" in entity:
			entity.take_damage(20)
			
func take_damage(damage):
	if vulnerable:
		health -= damage
		vulnerable = false
		$Timers/VulnerableTimer.start()
		if health <= 0:
			queue_free()

func _on_vulnerable_timer_timeout() -> void:
	vulnerable = true
