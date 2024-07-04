extends LevelParent

# can't reload outside.tscn because it is the main scene?
var outside_level_scene: PackedScene = load("res://scenes/levels/outside.tscn")

func _on_exit_gate_area_body_entered(_body: Node2D) -> void:
	self.tween_stop_player()
	get_tree().change_scene_to_packed.bind(outside_level_scene).call_deferred()
