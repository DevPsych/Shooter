extends StaticBody2D
class_name ItemParent

@onready var current_direction: Vector2 = Vector2.DOWN.rotated(self.global_rotation)

var opened: bool = false

signal open(pos, direction)
