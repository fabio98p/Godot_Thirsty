extends Node

var config = ConfigFile.new()
const SETTING_FILE_PATH = "user://settings.ini"

func _ready() -> void:
	#se non esiste un settings.ini nel path allora ne creo uno con gli elementi da salvare
	#[Audio]
	#-master_volume = 1.0
	#-sfx = 1.0
	if !FileAccess.file_exists(SETTING_FILE_PATH):
		config.set_value("audio", "master_volume", 0.005)
		config.set_value("audio", "music_volume", 0.005)
		config.set_value("audio", "sfx_volume", 0.005)
		config.save(SETTING_FILE_PATH)
	else:
	#altrimenti carico i dati del file settings.ini
		config.load(SETTING_FILE_PATH)
		
	#funzione che permette di salvare nel "ramo" audio i valori di una chiave es. master_volume e il valore
func save_audio_setting(key: String, value):
	config.set_value("audio", key, value)
	config.save(SETTING_FILE_PATH)
	#funzione per caricare i settings audio, per ogni chiave (es. master_volume, sfx etc... nella sezione "audio"
	#salvo nella variabile audio_settings la chiave.
func load_audio_setting():
	var audio_settings = {}
	for key in config.get_section_keys("audio"):
		audio_settings[key] = config.get_value("audio", key)
	return audio_settings
