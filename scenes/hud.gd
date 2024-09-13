extends Control

func _ready() -> void:
	hide_text()

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
