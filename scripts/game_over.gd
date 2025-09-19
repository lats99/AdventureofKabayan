extends Control

func _ready() -> void:
	pass

func _on_retry_button_pressed() -> void:
	get_tree().reload_current_scene()
	
func set_score(value):
	$Panel/Score.text = "Score: " + str(value)
	
func set_high_score(value):
	$Panel/HighScore.text = "High Score: " + str(value)
