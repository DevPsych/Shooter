extends Node2D

const LASER_SCENE: PackedScene = preload("res://scenes/projectiles/laser.tscn")
const GRENADE_SCENE: PackedScene = preload("res://scenes/projectiles/grenade.tscn")

func _on_gate_player_entered_gate(body: Node2D) -> void:
	print("Player has entered gate.")
	print(body)


func _on_player_laser(pos, direction) -> void:
	var laser = LASER_SCENE.instantiate() as Area2D
	laser.position = pos
	laser.rotation = direction.angle()
	laser.direction = direction
	$Projectiles.add_child(laser)

func _on_player_grenade(pos, direction) -> void:
	var grenade = GRENADE_SCENE.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.speed
	$Projectiles.add_child(grenade)
