extends Node2D


func _on_gate_player_entered_gate(body: Node2D) -> void:
	print("Player has entered gate.")
	print(body)


func _on_player_laser() -> void:
	print("laser from level")


func _on_player_grenade() -> void:
	print("grenade from level")
