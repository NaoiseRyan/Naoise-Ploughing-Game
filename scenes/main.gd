extends Node2D

var heart_scene = preload("res://scenes/heart_item.tscn")

signal tutorial_over

func _ready() -> void:
	$Menus.show()
	$Player.hide()
	$Background.hide()
	$Hud.hide()

func _on_main_menu_game_start() -> void:
	$Menus.hide()
	$Player.position.x = get_viewport_rect().size.x/2
	$Player.position.y = get_viewport_rect().size.y/1.5
	$Player.show()
	$Background.show()
	$Hud.show()
	await $Hud.display_tutorial_text() #displays the 3 lines of text
	end_tutorial()

func end_tutorial() -> void:
	tutorial_over.emit()
	$Background/Bg_Parallax.autoscroll.y = 1000
	$HeartSpawner.start()


func _on_heart_spawner_timeout() -> void:
	var new_heart = heart_scene.instantiate()
	$Spawn_Path.add_child(new_heart)
	new_heart.position = get_random_spawn_point()


func get_random_spawn_point():
	var random_point = $Spawn_Path/Spawn_Path_Point
	random_point.progress_ratio = randf()
	return random_point.position
