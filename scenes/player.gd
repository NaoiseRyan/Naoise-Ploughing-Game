extends CharacterBody2D


const SPEED = 700.0
const JUMP_VELOCITY = -400.0
var screen_size

signal peace_shield_end

func _ready():
	screen_size = get_viewport_rect().size
	disable_peace_shield()
	
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


func _on_menus_game_start() -> void:
	$AnimatedSprite2D.play("fly")


func _on_peace_shield_timer_timeout() -> void:
	disable_peace_shield()
	
func enable_peace_shield():
	$peace_shield.show()
	$peace_shield/CollisionShape2D.set_deferred("disabled", false)
	$peace_shield/peace_shield_timer.start()

func disable_peace_shield():
	$peace_shield.hide()
	$peace_shield/CollisionShape2D.set_deferred("disabled", true)
	peace_shield_end.emit()

func _on_peace_shield_area_entered(area: Area2D) -> void:
	area.destroy_self()
	print(area)
