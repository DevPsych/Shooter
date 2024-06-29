extends CharacterBody2D


const SPEED: float = 300.0

func _physics_process(_delta: float) -> void:
	var direction: Vector2 = Vector2.RIGHT
	self.velocity = direction * SPEED
	self.move_and_slide()
