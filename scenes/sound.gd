extends TextureButton

@export var icon_mode_sound : Texture2D
@export var icon_mode_mute : Texture2D

var sfx_bus = AudioServer.get_bus_index("Master")

func audio_mute (mute_it:bool):
	AudioServer.set_bus_mute(sfx_bus, mute_it)
	
func is_audio_muted() -> bool:
	return AudioServer.is_bus_mute(sfx_bus)
	
func toggle_mute():
	audio_mute(!is_audio_muted())
	
func update_button_icon():
	if is_audio_muted():
		texture_normal = icon_mode_mute
	else:
		texture_normal = icon_mode_sound

func _on_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		AudioServer.set_bus_mute(sfx_bus, is_audio_muted())
	else:
		AudioServer.set_bus_mute(sfx_bus, !is_audio_muted())
	
