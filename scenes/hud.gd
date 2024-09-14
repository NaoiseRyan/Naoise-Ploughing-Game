extends Control

signal release_peace

var score = 0

var sb = StyleBoxFlat.new()


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
	score = new_score
	$Score_Count.text = str(score)


func _on_menus_game_start() -> void:
	var score = 0

func update_peace_meter(score):
	$ProgressBar.value += score
	if $ProgressBar.value > 100:
		$ProgressBar.value = 100


func _on_progress_bar_value_changed(value: float) -> void:
	if $ProgressBar.value >= 100:
		sb.bg_color = Color("ffc905")
		release_peace.emit()
	else:
		update_peace_meter_color()

func update_peace_meter_color():
	$ProgressBar.add_theme_stylebox_override("fill", sb)
	sb.bg_color = Color("ffc905")
	await get_tree().create_timer(0.5).timeout
	sb.bg_color = Color("ff7a05")

func reset_peace_meter():
	$ProgressBar.value = 0


func _on_player_peace_shield_end() -> void:
	reset_peace_meter()

func update_health_bar(health):
	$Health_bar.value = (health * 20)
