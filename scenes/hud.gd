extends Control

var score = 0

func _ready() -> void:
	hide_text()
	$Score_Count.text = str(score)

func hide_text():
	$Tutorial_Text.hide()
	$Tutorial_Text/Collect_Love.hide()
	$Tutorial_Text/Spread_Peace.hide()
	$Tutorial_Text/Avoid_War.hide()

func display_tutorial_text():
	hide_text()
	$Tutorial_Text.show()
	await get_tree().create_timer(1).timeout
	$Tutorial_Text/Collect_Love.show()
	await get_tree().create_timer(1).timeout
	$Tutorial_Text/Spread_Peace.show()
	await get_tree().create_timer(1).timeout
	$Tutorial_Text/Avoid_War.show()
	await get_tree().create_timer(2).timeout
	hide_text()
	
func update_score(new_score):
	score += new_score
	$Score_Count.text = str(score)


func _on_menus_game_start() -> void:
	var score = 0
