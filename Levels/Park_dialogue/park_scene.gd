extends Control

@onready var dialog_sistem: Control = $DialogSistem
@export var dialogue_value: String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dialog_sistem.start_dialogue(dialogue_value)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
