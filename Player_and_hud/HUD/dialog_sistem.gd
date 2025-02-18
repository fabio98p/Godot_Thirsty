extends Control

@onready var player_img_dialogue: Panel = $Player_img_dialogue
@onready var npc_img_dialogue: Panel = $Npc_img_dialogue
@onready var speack_person: Label = $Speack_person
@onready var dialog: Label = $VBoxContainer/Dialog
@onready var button: Button = $Button
@onready var ez_dialogue: EzDialogue = $EzDialogue
@export var dialog_json: JSON 
@onready var state= {}

@export var text_speed = 0.02# Tempo tra una lettera e l'altra (in secondi)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ez_dialogue.start_dialogue(dialog_json, state,)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func clear_dialog():
	dialog.text = ""
	
func change_dialog(text: String):
	speack_person.text = state["dialogue_name"]
	priorityze_speaker_imgtxt(state)
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

#vado a estrapolare il nome dai segnali custom di ezdialog
func _on_ez_dialogue_custom_signal_received(value: Variant) -> void:
	var params = value.split(",")
	if params[0] == "set":
		var variable_name = params[1]
		var variable_value = params[2]
		state[variable_name] = variable_value
		
	if params[0] == "get":
		print(params, "parametri")
		var variable_expression = params[1]
		var variable_expression_value = params[2]	
		state[variable_expression]= variable_expression_value
		
		
#vado a dare priotià di colore all immagine di chi sta parlando, tra player o npc
func priorityze_speaker_imgtxt(state: Dictionary):
	var player_dialogue_stylebox = player_img_dialogue.get_theme_stylebox("panel")
	var npc_dialogue_stylebox = npc_img_dialogue.get_theme_stylebox("panel")
	print(state, "stato")
	if state["dialogue_name"] == "Kevin":
		
		if player_dialogue_stylebox && npc_dialogue_stylebox is StyleBoxTexture :
			player_dialogue_stylebox.modulate_color = Color(1,1,1,1) 
			npc_dialogue_stylebox.modulate_color = Color(0.204, 0.204, 0.204, 0.686)
			
	else:
		npc_dialogue_stylebox.modulate_color = Color(1,1,1,1) 
		player_dialogue_stylebox.modulate_color = Color(0.204, 0.204, 0.204, 0.686)
		
