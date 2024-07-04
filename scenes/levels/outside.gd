extends LevelParent

@export var inside_level_scene: PackedScene = preload("res://scenes/levels/inside.tscn")

func _on_house_player_entered() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(%Camera2D,"zoom",Vector2(1,1),1)

func _on_house_player_exited() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(%Camera2D,"zoom",Vector2(0.6,0.6),1)

func _on_gate_player_entered_gate(_body: Node2D) -> void:
	self.tween_stop_player()
	get_tree().change_scene_to_packed.bind(inside_level_scene).call_deferred()
	
