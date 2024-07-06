extends Node

signal stat_changed(stat_name: String)

var laser_amount: int = 20:
	get:
		return laser_amount
	set(value):
		laser_amount = value
		stat_changed.emit("laser")
		
var grenade_amount: int = 5:
	get:
		return grenade_amount
	set(value):
		grenade_amount = value
		stat_changed.emit("grenade")
		
var health: int = 60:
	get:
		return health
	set(value):
		health = value
		stat_changed.emit("health")

var player_pos: Vector2
