extends Area2D

@export var speed: int = 1000
var direction: Vector2 = Vector2.UP #This will be overridden by the player's direction gotten from signal

func _process(delta: float) -> void:
	self.position += direction * speed * delta
