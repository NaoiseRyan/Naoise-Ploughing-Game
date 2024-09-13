extends Control

signal game_start

func _ready() -> void:
	$Main_Menu.show()
	$Credits_Menu.hide()

func _on_start_game_button_up() -> void:
	game_start.emit()


func _on_credits_button_up() -> void:
	$Main_Menu.hide()
	$Credits_Menu.show()


func _on_go_back_button_up() -> void:
	$Main_Menu.show()
	$Credits_Menu.hide()
