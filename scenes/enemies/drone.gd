extends CharacterBody2D

var vulnerable: bool = true
var player_detected: bool = false
var has_exploded: bool = false

var entities_in_explosion: Array
var drone_damage: int = 5

@export var speed: int = 300
var health: int = 50

func _ready():
	$DroneSprite.show()
	$ExplosionSprite.hide()
	$ExplosionArea/CollisionShape2D.disabled = true

func _process(delta: float) -> void:
	if player_detected and not has_exploded:
		self.look_at(Globals.player_pos)
		var direction: Vector2 = (Globals.player_pos - self.position).normalized()
		var tween = create_tween()
		tween.tween_property(self,"speed",1000,4.0)
		self.velocity = direction * speed
		var collided = self.move_and_collide(velocity * delta)
		if collided:
			$AnimationPlayer.play("explosion")
			has_exploded = true
	for entity in entities_in_explosion:
		if "take_damage" in entity:
			entity.take_damage(drone_damage)
	
func take_damage(damage):
	if vulnerable:
		health -= damage
		vulnerable = false
		$VulnerableTimer.start()
		$DroneSprite.material.set_shader_parameter("progress", 0.8)
		if health <= 0:
			$AnimationPlayer.play("explosion")

func _on_vulnerable_timer_timeout() -> void:
	vulnerable = true
	$DroneSprite.material.set_shader_parameter("progress", 0)

func _on_notice_area_body_entered(_body: Node2D) -> void:
	player_detected = true

func _on_explosion_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("entities") or body.is_in_group("containers"):
		entities_in_explosion.append(body)

func _on_explosion_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("entities") or body.is_in_group("containers"):
		entities_in_explosion.erase(body)
