extends Control

@onready var dialog_sistem: Control = $DialogSistem
@export var dialogue_value: String
@export var backgrounds:Dictionary = {
	"bg_bed_room" : "",
	"bg_bath_room" : "",
	"bg_entrance_house" : "",
}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("/root/AudioStreamPlayer2d").playing = false
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
