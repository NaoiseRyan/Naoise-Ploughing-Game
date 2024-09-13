extends CharacterBody2D


const SPEED = 700.0
const JUMP_VELOCITY = -400.0
var screen_size


func _ready():
	screen_size = get_viewport_rect().size
	
func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	position.x = clamp(position.x,64, screen_size.x - 64)
