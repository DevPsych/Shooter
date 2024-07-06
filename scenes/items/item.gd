extends Area2D

@export var rotation_speed: int = 4
var available_options = ["laser", "laser", "laser", "laser", "grenade", "health"]
var type = available_options[randi()%len(available_options)]

func _ready():
	if type == "laser":
		$Sprite2D.modulate = Color(0.2,0.1,0.8)
	elif type == "grenade":
		$Sprite2D.modulate = Color(0.8,0.1,0.2)
	elif type == "health":
		$Sprite2D.modulate = Color(0.2,0.8,0.1)

func _process(delta):
	self.rotation += rotation_speed * delta
	
func _on_body_entered(_body: Node2D) -> void:
	if type == "health":
		Globals.health += 10
	elif type == "laser":
		Globals.laser_amount += 5
	elif type == "grenade":
		Globals.grenade_amount += 1
	queue_free()
