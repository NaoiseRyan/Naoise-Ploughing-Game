extends Area2D

signal player_collision

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += 10
	if position.y > 1280:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	player_collision.emit()
	queue_free()
