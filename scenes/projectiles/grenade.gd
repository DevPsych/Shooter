extends RigidBody2D

@export var speed: int = 1000
var direction: Vector2 = Vector2.UP

func _ready():
	self.linear_velocity = direction * speed
