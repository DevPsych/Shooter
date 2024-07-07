extends PathFollow2D

@onready var line1: Line2D = $Turret/RayCast2D/Line2D
@onready var line2: Line2D = $Turret/RayCast2D2/Line2D

var player_detected: bool = false

var entities_in_los: Array

var speed = 0.02

func _process(delta):
	self.progress_ratio += speed * delta
	
	if player_detected:
		$Turret.look_at(Globals.player_pos)

func shoot():
	for entity in entities_in_los:
		if player_detected and "take_damage" in entity:
			entity.take_damage(20)

func _on_notice_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_detected = true
		entities_in_los.append(body)
		$AnimationPlayer.play("laser_load")
	
func _on_notice_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_detected = false
		entities_in_los.erase(body)
		$AnimationPlayer.pause()
		var tween = create_tween()
		tween.set_parallel(true)
		tween.tween_property(line1,"width",0,0.2)
		tween.tween_property(line2,"width",0,0.2)
		await tween.finished
		$AnimationPlayer.stop()
