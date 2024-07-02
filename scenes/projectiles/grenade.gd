extends RigidBody2D

@export var speed: int = 1000
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func explode():
	animation_player.play("Explosion")
