extends Node2D

var test_array: Array[String] = ["string", "hello", "stuff"] 

func _ready():
	$Logo.rotation_degrees = 90
	
	#for i in test_array:
		#print(i)

func _process(delta: float):
	$Logo.rotation_degrees += 200 * delta

	if $Logo.position.x > 1000:
		$Logo.pos.x = 0
