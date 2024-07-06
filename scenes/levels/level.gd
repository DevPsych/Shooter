extends Node2D
class_name LevelParent

const LASER_SCENE: PackedScene = preload("res://scenes/projectiles/laser.tscn")
const GRENADE_SCENE: PackedScene = preload("res://scenes/projectiles/grenade.tscn")
const ITEM_SCENE: PackedScene = preload("res://scenes/items/item.tscn")

func _ready():
	for container in get_tree().get_nodes_in_group("containers"):
		container.connect("open",on_container_open)
		
func on_container_open(pos, direction) -> void:
	var item = ITEM_SCENE.instantiate() as Area2D
	item.position = pos
	item.direction = direction
	$Items.call_deferred("add_child",item)

func _on_player_laser(pos, direction) -> void:
	var laser = LASER_SCENE.instantiate() as Area2D
	laser.position = pos
	laser.rotation = direction.angle()
	laser.direction = direction
	$Projectiles.add_child(laser)
	$UI.update_laser_label()

func _on_player_grenade(pos, direction) -> void:
	var grenade = GRENADE_SCENE.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.speed
	$Projectiles.add_child(grenade)
	$UI.update_grenade_label()

func tween_stop_player():
	var tween = create_tween()
	tween.tween_property($Player,"speed",0,0.5)

func _on_player_update_stats() -> void:
	$UI.update_laser_label()
	$UI.update_grenade_label()
