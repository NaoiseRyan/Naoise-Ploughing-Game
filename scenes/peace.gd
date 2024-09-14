extends Area2D

signal player_collision

const SCORE_VALUE = 3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += 10
	if position.y > 1350:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	player_collision.emit()
	$CollisionShape2D.set_deferred("disabled", true)
	$Sprite2D.hide()
	create_death_score_label()
	await get_tree().create_timer(2).timeout
	queue_free()

func create_death_score_label():
	#Creating the score label on enemy
	var death_score_label = Label.new()
	death_score_label.set("theme_override_colors/font_color",Color(0.0,1.0,0.0,1.0))
	add_child(death_score_label)
	death_score_label.text = str(SCORE_VALUE)
	death_score_label.anchors_preset = 8
	death_score_label.add_theme_font_size_override("font_size", 100)
	#Tween to make text fly up after spawning
	var position_tween = create_tween()
	position_tween.tween_property(death_score_label, "position:y", death_score_label.position.y - 40, .35)
	var alpha_tween = create_tween()
	alpha_tween.tween_property(death_score_label, "modulate:a", 0, 1)
