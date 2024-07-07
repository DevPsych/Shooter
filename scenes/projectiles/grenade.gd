extends RigidBody2D

@export var speed: int = 1000
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var entity_is_in_explosion: bool = false
var entity: Node2D

func explode():
	animation_player.play("Explosion")
	
func _process(_delta):
	if entity_is_in_explosion and "take_damage" in entity:
		entity.take_damage()

func _on_explosion_radius_body_entered(body: Node2D) -> void:
	if body.is_in_group("entities") or body.is_in_group("containers"):
		entity_is_in_explosion = true
		entity = body

func _on_explosion_radius_body_exited(body: Node2D) -> void:
	if body.is_in_group("entities") or body.is_in_group("containers"):
		entity_is_in_explosion = false
