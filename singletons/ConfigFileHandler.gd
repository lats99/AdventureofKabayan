extends Node

var config = ConfigFile.new()
const SETTING_FILE_PATH = "user://KabayanJetpackSettings.ini"

func _ready() -> void:
	if !FileAccess.file_exists(SETTING_FILE_PATH):
		config.set_value("audio", "is_muted", false)
		
		config.save(SETTING_FILE_PATH)
	else:
		config.load(SETTING_FILE_PATH)
		
func save_audio_settings(key: String, value):
	config.set_value("audio", key, value)
	config.save(SETTING_FILE_PATH)
	
func load_audio_settings():
	var audio_settings = {}
	for key in config.get_section_keys("audio"):
		audio_settings[key] = config.get_value("audio", key)
	return audio_settings
	
