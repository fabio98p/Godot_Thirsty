extends Control
@onready var audio_stream_player_2d_2: AudioStreamPlayer2D = $AudioStreamPlayer2D2

@onready var dialog_sistem: Control = $DialogSistem
@export var dialogue_value: String
@export var backgrounds:Dictionary = {
	"bg_sunrise" : "",
}
@export var npc_expression:Dictionary = {
	"zugplupangry" : "",
	"alicespeack" : "",
	"aliceidle" : "",
	"alicesurprise" : "",
	"sergentespeack" : "",
	"sergenteidle" : "",
	"sergentessurprise" : "",
	"notthing":""
}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("/root/AudioStreamPlayer2d").playing = false
	audio_stream_player_2d_2.playing = true
	dialog_sistem.start_dialogue(dialogue_value)
	#dialog_sistem.change_background_scene(bg_bed_room)
	dialog_sistem.get_node("EzDialogue").connect("custom_signal_received", Callable(self, "change_background"))
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func change_background(value: Variant):
	var params = value.split(",")
	if params[0] == "set":
		var variable_name = params[1]
		var variable_value = params[2]
		#state[variable_name] = variable_value
		if variable_name == "background":
			dialog_sistem.change_background_scene(backgrounds[variable_value])
		if variable_name == "npc_name":
			if variable_value == "null":
				dialog_sistem.npc_img_dialogue.visible = false 
			else:
				dialog_sistem.npc_img_dialogue.visible = true 
		if variable_name == "npc_expression":
			dialog_sistem.change_npc_img_dialogue(npc_expression[variable_value])
