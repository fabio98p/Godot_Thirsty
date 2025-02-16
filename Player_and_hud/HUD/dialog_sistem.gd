extends Control

@onready var dialog: Label = $VBoxContainer/Dialog
@onready var button: Button = $VBoxContainer/Button
@onready var ez_dialogue: EzDialogue = $EzDialogue
@export var dialog_json: JSON 
@onready var state= {}

@export var text_speed = 0.01# Tempo tra una lettera e l'altra (in secondi)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ez_dialogue.start_dialogue(dialog_json, state)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func clear_dialog():
	dialog.text = ""
	
func change_dialog(text: String):
	dialogue_slow_effect(text)
	#dialog.text = text

func _on_ez_dialogue_dialogue_generated(response: DialogueResponse) -> void:
	clear_dialog()
	change_dialog(response.text)
	
func _on_button_pressed() -> void:
	ez_dialogue.next()
	
	#funzioni per il testo in slowmotion mostra lettera per lettara disabilitando il bottone
func dialogue_slow_effect(new_text: String):
	button.disabled = true
	var full_text = new_text
	var current_text = ""
	dialog.text = ""
	for i in range(full_text.length()):
		current_text += full_text[i]
		dialog.text = current_text
		await get_tree().create_timer(text_speed).timeout
		if i == (full_text.length()-1):
			button.disabled = false
