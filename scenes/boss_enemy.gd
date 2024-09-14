extends StaticBody2D

signal player_collision

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += 10
	if position.y > 1350:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	player_collision.emit()
	queue_free()

func destroy_self():
	queue_free()
