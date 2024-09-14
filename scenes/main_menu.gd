extends Control

signal game_start

func _ready() -> void:
	$Main_Menu.show()
	$Credits_Menu.hide()
	$Lose_Menu.hide()

func _on_start_game_button_up() -> void:
	game_start.emit()


func _on_credits_button_up() -> void:
	$Main_Menu.hide()
	$Credits_Menu.show()


func _on_go_back_button_up() -> void:
	$Main_Menu.show()
	$Credits_Menu.hide()


func _on_lose_button_pressed() -> void:
	$Lose_Menu.hide()
	$Main_Menu.show()

func game_over_screen():
	$Lose_Menu.show()
	$Main_Menu.hide()
	$Credits_Menu.hide()

func update_score(score):
	$Lose_Menu/Score_title/Score_amount.text = str(score)
