extends RigidBody2D

@export var speed: int = 1000
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var entities_in_explosion: Array
var grenade_damage: int = 5

func _ready():
	$Sprite2D.show()

func explode():
	animation_player.play("Explosion")
	
func _process(_delta):
	for entity in entities_in_explosion:
		if "take_damage" in entity:
			entity.take_damage(grenade_damage)

func _on_explosion_radius_body_entered(body: Node2D) -> void:
	if body.is_in_group("entities") or body.is_in_group("containers"):
		entities_in_explosion.append(body)

func _on_explosion_radius_body_exited(body: Node2D) -> void:
	if body.is_in_group("entities") or body.is_in_group("containers"):
		entities_in_explosion.erase(body)
