extends CanvasLayer

# colors
var green: Color = Color("6bbfa3")
var red: Color = Color(.9,0,0,1)

@onready var laser_label: Label = $MarginContainer2/HBoxContainer/LaserCounter/LaserLabel
@onready var grenade_label: Label = $MarginContainer2/HBoxContainer/GrenadeCounter/GrenadeLabel
@onready var laser_icon: TextureRect = $MarginContainer2/HBoxContainer/LaserCounter/LaserIcon
@onready var grenade_icon: TextureRect = $MarginContainer2/HBoxContainer/GrenadeCounter/GrenadeIcon
@onready var health_progress_bar: TextureProgressBar = $MarginContainer/HealthProgressBar

func _ready():
	Globals.connect("health_changed", update_health_bar)
	Globals.connect("laser_amount_changed", update_laser_label)
	Globals.connect("grenade_amount_changed", update_grenade_label)
	
	update_laser_label()
	update_grenade_label()
	update_color(Globals.laser_amount, laser_label, laser_icon)
	update_color(Globals.grenade_amount, grenade_label, grenade_icon)
	update_health_bar()

func update_laser_label():
	laser_label.text = str(Globals.laser_amount)
	update_color(Globals.laser_amount, laser_label, laser_icon)

func update_grenade_label():
	grenade_label.text = str(Globals.grenade_amount)
	update_color(Globals.grenade_amount, grenade_label, grenade_icon)
	
func update_color(amount: int, label: Label, icon: TextureRect) -> void:
	if amount > 0:
		label.modulate = green
		icon.modulate = green
	else:
		label.modulate = red
		icon.modulate = red

func update_health_bar():
	health_progress_bar.value = Globals.health
