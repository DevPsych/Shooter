extends Sprite2D

var pos: Vector2 = Vector2.ZERO
var test_scale: int = 1
const speed: int = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pos = Vector2(100,200)
	self.position = pos

	var test_rotation: int = 45
	self.rotation_degrees = test_rotation
	
	test_scale = 2
	self.scale = Vector2(test_scale, test_scale)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pos.x += speed
	self.position = pos
	test_scale += 1
	self.scale = Vector2(test_scale, test_scale)
