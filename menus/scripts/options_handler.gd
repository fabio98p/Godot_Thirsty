extends Node

var audio_settings
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#vado a caricarmi i dati audio salvati sul file config
	audio_settings = ConfigFileHandler.load_audio_setting()
	change_audio_bus(min(audio_settings.master_volume, 1.0)*100, 0)
	change_audio_bus(min(audio_settings.music_volume, 1.0)*100, 0)
	change_audio_bus(min(audio_settings.sfx_volume, 1.0)*100, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



	#funzione per cambiare il volume bus in audio in base a dove chiami
func change_audio_bus(value: float, index: int):
	AudioServer.set_bus_volume_db(index, linear_to_db(value))
	audio_settings = ConfigFileHandler.load_audio_setting()
	return value
