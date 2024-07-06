extends ItemParent

func take_damage():
	if not opened:
		$LidSprite.hide()
		for i in range(5):
			var pos = $SpawnPositions.get_child(randi() % $SpawnPositions.get_child_count()).global_position
			open.emit(pos, self.current_direction)
		opened = true
