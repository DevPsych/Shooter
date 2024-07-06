extends Node2D
class_name LevelParent

const LASER_SCENE: PackedScene = preload("res://scenes/projectiles/laser.tscn")
const GRENADE_SCENE: PackedScene = preload("res://scenes/projectiles/grenade.tscn")
const ITEM_SCENE: PackedScene = preload("res://scenes/items/item.tscn")

func _ready():
	for container in get_tree().get_nodes_in_group("containers"):
		container.connect("open",_on_container_open)
	for scout in get_tree().get_nodes_in_group("scouts"):
		scout.connect("laser",_on_scout_laser)
		
func _on_container_open(pos, direction) -> void:
	var item = ITEM_SCENE.instantiate() as Area2D
	item.position = pos
	item.direction = direction
	$Items.call_deferred("add_child",item)

func _on_player_laser(pos, direction) -> void:
	instantiate_laser(pos, direction)
	
func _on_scout_laser(pos, direction) -> void:
	instantiate_laser(pos, direction)

func instantiate_laser(pos, direction) -> void:
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

func tween_stop_player():
	var tween = create_tween()
	tween.tween_property($Player,"speed",0,0.5)
