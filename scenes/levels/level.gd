extends Node2D

const LASER_SCENE: PackedScene = preload("res://scenes/projectiles/laser.tscn")
const GRENADE_SCENE: PackedScene = preload("res://scenes/projectiles/grenade.tscn")

func _on_gate_player_entered_gate(body: Node2D) -> void:
	print("Player has entered gate.")
	print(body)


func _on_player_laser(pos) -> void:
	var laser = LASER_SCENE.instantiate()
	laser.position = pos
	$Projectiles.add_child(laser)

func _on_player_grenade(pos) -> void:
	var grenade = GRENADE_SCENE.instantiate()
	grenade.position = pos
	$Projectiles.add_child(grenade)
