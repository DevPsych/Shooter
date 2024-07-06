extends Node

signal health_changed
signal laser_amount_changed
signal grenade_amount_changed

var laser_amount: int = 20:
	get:
		return laser_amount
	set(value):
		laser_amount = value
		laser_amount_changed.emit()
		
var grenade_amount: int = 5:
	get:
		return grenade_amount
	set(value):
		grenade_amount = value
		grenade_amount_changed.emit()
		
var health: int = 60:
	get:
		return health
	set(value):
		health = value
		health_changed.emit()
