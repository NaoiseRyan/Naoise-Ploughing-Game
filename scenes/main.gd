extends Node2D

var heart_scene = preload("res://scenes/heart_item.tscn")
var peace_scene = preload("res://scenes/peace.tscn")
var npc_hostile_scene = preload("res://scenes/npc_hostile.tscn")

var difficulty_modifier = 1

signal tutorial_over

func _ready() -> void:
	$Menus.show()
	$Player.hide()
	$Background.hide()
	$Hud.hide()
	$tap_screen_sprite_left.hide()
	$tap_screen_sprite_right.hide()
	$Press_to_move_label.hide()

func display_tap_screen():
	$tap_screen_sprite_left.show()
	$tap_screen_sprite_left.play("default")
	$tap_screen_sprite_right.show()
	$tap_screen_sprite_right.play("default")
	$Press_to_move_label.show()
	await get_tree().create_timer(3.5).timeout
	$tap_screen_sprite_left.hide()
	$tap_screen_sprite_right.hide()
	$Press_to_move_label.hide()

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
	$enemySpawner.start()
	$peaceSpawner.start()
	$Increase_Difficulty.start()
	display_tap_screen()


func _on_heart_spawner_timeout() -> void:
	$HeartSpawner.wait_time = RandomNumberGenerator.new().randf_range(0.15 * difficulty_modifier, 2 * difficulty_modifier)
	var new_heart = heart_scene.instantiate()
	$Spawn_Path.add_child(new_heart)
	new_heart.player_collision.connect(player_pickup_heart)
	new_heart.position = get_random_spawn_point()


func get_random_spawn_point():
	var random_point = $Spawn_Path/Spawn_Path_Point
	random_point.progress_ratio = randf()
	return random_point.position

func player_pickup_heart():
	$Hud.update_score(1)


func _on_enemy_spawner_timeout() -> void:
	$enemySpawner.wait_time = RandomNumberGenerator.new().randf_range(.4 / difficulty_modifier + 0.25, 3 / difficulty_modifier)
	var new_enemy = npc_hostile_scene.instantiate()
	$Spawn_Path.add_child(new_enemy)
	new_enemy.player_collision.connect(player_hit_enemy)
	new_enemy.position = get_random_spawn_point()

func player_hit_enemy():
	$Hud.update_score(-2)


func _on_peace_spawner_timeout() -> void:
	$peaceSpawner.wait_time = RandomNumberGenerator.new().randf_range(4, 12)
	var new_peace = peace_scene.instantiate()
	$Spawn_Path.add_child(new_peace)
	new_peace.player_collision.connect(player_pickup_peace)
	new_peace.position = get_random_spawn_point()

func player_pickup_peace():
	$Hud.update_peace_meter(20)
	$Hud.update_score(3)


func _on_hud_release_peace() -> void:
	$Player.enable_peace_shield()


func _on_increase_difficulty_timeout() -> void:
	difficulty_modifier += 0.25
	$Background/Bg_Parallax.autoscroll.y += 100
	print("aa")
