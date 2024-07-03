extends Area2D

@export var speed: int = 1000
var direction: Vector2 = Vector2.UP #This will be overridden by the player's direction gotten from signal

func _ready():
	$SelfDestructTimer.start()

func _process(delta: float) -> void:
	self.position += direction * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if "take_damage" in body:
		body.take_damage()
	self.queue_free()

func _on_timer_timeout() -> void:
	self.queue_free()
