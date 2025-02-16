extends Control

@onready var dialog: Label = $VBoxContainer/Dialog
@onready var button: Button = $VBoxContainer/Button
@onready var ez_dialogue: EzDialogue = $EzDialogue
@export var dialog_json: JSON 
@onready var state= {}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ez_dialogue.start_dialogue(dialog_json, state)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func clear_dialog():
	dialog.text = ""
	
func change_dialog(text: String):
	dialog.text = text

func _on_ez_dialogue_dialogue_generated(response: DialogueResponse) -> void:
	clear_dialog()
	change_dialog(response.text)
	
func _on_button_pressed() -> void:
	ez_dialogue.next()
