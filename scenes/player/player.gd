extends Node2D

var speed: float = 300

func _process(delta: float) -> void:
	var direction: Vector2 = Input.get_vector("left", "right","up","down")
	self.position += direction * speed * delta
