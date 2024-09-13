extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("im alive")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += 10
