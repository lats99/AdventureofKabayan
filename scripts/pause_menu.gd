extends Control

@onready var pause_menu: Control = $"."
@onready var sound: TextureButton = $Panel/Sound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var sound_settings =  ConfigFileHandler.load_audio_settings()
	sound.button_pressed = sound_settings.is_muted

func esc():
	if Input.is_action_just_pressed("pause") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("pause") and get_tree().paused == true:
		resume()

func pause():
	get_tree().paused = true
	
func resume():
	get_tree().paused = false
	pause_menu.visible=false
	
func _on_resume_pressed() -> void:
	resume()

func _on_retry_pressed() -> void:
	resume()
	get_tree().reload_current_scene()

func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_sound_toggled(toggled_on: bool) -> void:
	sound.toggle_mute()
	ConfigFileHandler.save_audio_settings("is_muted", toggled_on)
	sound.update_button_icon()

func _process(_delta: float) -> void:
	esc()
	
