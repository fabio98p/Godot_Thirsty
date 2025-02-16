extends Control

@onready var master_slide: HSlider = $AudioControl/Buttons_cont/Master_slide
@onready var music_slide: HSlider = $AudioControl/Buttons_cont/Music_slide
@onready var sfx_slide: HSlider = $AudioControl/Buttons_cont/Sfx_slide

signal hide_option_menu 

func _ready() -> void:
	#vado a settare la barra del master in base al valore salvato nel config 
	master_slide.value = min(OptionsHandler.audio_settings.master_volume, 1.0)*100
	music_slide.value = min(OptionsHandler.audio_settings.music_volume, 1.0)*100
	sfx_slide.value = min(OptionsHandler.audio_settings.sfx_volume, 1.0)*100
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _on_button_back_pressed() -> void:
	hide_option_menu.emit()


func _on_master_slide_drag_ended(value_changed: bool) -> void:
	if value_changed:
		#se il valore è cambiato allora vado a chiamare la funzione per passare i dati da salvare
		ConfigFileHandler.save_audio_setting("master_volume", master_slide.value/100)
		OptionsHandler.change_audio_bus(master_slide.value, 0)

func _on_music_slide_drag_ended(value_changed: bool) -> void:
	if value_changed:
		#se il valore è cambiato allora vado a chiamare la funzione per passare i dati da salvare
		ConfigFileHandler.save_audio_setting("music_volume", music_slide.value/100)
		OptionsHandler.change_audio_bus(music_slide.value, 0)


func _on_sfx_slide_drag_ended(value_changed: bool) -> void:
	if value_changed:
		#se il valore è cambiato allora vado a chiamare la funzione per passare i dati da salvare
		ConfigFileHandler.save_audio_setting("sfx_volume", sfx_slide.value/100)
		OptionsHandler.change_audio_bus(sfx_slide.value, 0)
	
