extends CanvasLayer

@onready var laser_label: Label = $MarginContainer2/HBoxContainer/LaserCounter/LaserLabel
@onready var grenade_label: Label = $MarginContainer2/HBoxContainer/GrenadeCounter/GrenadeLabel

func _ready():
	update_laser_label()
	update_grenade_label()

func update_laser_label():
	laser_label.text = str(Globals.laser_amount)

func update_grenade_label():
	grenade_label.text = str(Globals.grenade_amount)
