extends Node2D

var heart_scene = preload("res://scenes/heart_item.tscn")
var peace_scene = preload("res://scenes/peace.tscn")
var npc_hostile_scene = preload("res://scenes/npc_hostile.tscn")

const MAX_HEALTH = 5
var health = MAX_HEALTH
var score = 0

var difficulty_modifier = 1

signal tutorial_over

signal game_over_signal

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
	score = 0
	$Hud.update_score(score)
	$Background/Bg_Parallax.autoscroll.y = 50
	$Menus.hide()
	$Hud.reset_peace_meter()
	health = MAX_HEALTH
	$Hud.update_health_bar(health)
	difficulty_modifier = 1
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
	$HeartSpawner.wait_time = RandomNumberGenerator.new().randf_range(1.5, 7)
	var new_heart = heart_scene.instantiate()
	$Spawn_Path.add_child(new_heart)
	new_heart.player_collision.connect(player_pickup_heart)
	new_heart.position = get_random_spawn_point()


func get_random_spawn_point():
	var random_point = $Spawn_Path/Spawn_Path_Point
	random_point.progress_ratio = randf()
	return random_point.position

func player_pickup_heart():
	health += 1
	score += 1
	prevent_health_overflow()
	$Hud.update_health_bar(health)
	$Hud.update_score(score)

func _on_enemy_spawner_timeout() -> void:
	$enemySpawner.wait_time = RandomNumberGenerator.new().randf_range(.4 / difficulty_modifier + 0.9, 3 / difficulty_modifier)
	var new_enemy = npc_hostile_scene.instantiate()
	$Spawn_Path.add_child(new_enemy)
	new_enemy.player_collision.connect(player_hit_enemy)
	new_enemy.position = get_random_spawn_point()

func player_hit_enemy():
	health -= 1
	score -= 2
	prevent_health_overflow()
	$Hud.update_health_bar(health)
	$Hud.update_score(score)

func prevent_health_overflow():
	if health > 5:
		health = 5
	elif health <= 0:
		$Menus.update_score(score)
		game_over()

func _on_peace_spawner_timeout() -> void:
	$peaceSpawner.wait_time = RandomNumberGenerator.new().randf_range(3, 10)
	var new_peace = peace_scene.instantiate()
	$Spawn_Path.add_child(new_peace)
	new_peace.player_collision.connect(player_pickup_peace)
	new_peace.position = get_random_spawn_point()

func player_pickup_peace():
	score += 3
	$Hud.update_peace_meter(20)
	$Hud.update_score(score)


func _on_hud_release_peace() -> void:
	$Player.enable_peace_shield()


func _on_increase_difficulty_timeout() -> void:
	difficulty_modifier += 1
	$Background/Bg_Parallax.autoscroll.y += 100

func game_over():
	game_over_signal.emit()
	$Menus.show()
	$Menus.game_over_screen()
	$HeartSpawner.stop()
	$enemySpawner.stop()
	$peaceSpawner.stop()
	$Increase_Difficulty.stop()
	$Background/Bg_Parallax.autoscroll.y = 0
	
