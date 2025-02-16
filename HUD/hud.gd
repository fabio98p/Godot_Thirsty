extends Control

@onready var panel: Panel = $Panel
@export var texture_path: Array[String]= []

func _ready() -> void:
	change_afterlife(4)

#questo script si occuperà solo di una cosa, ovvero captare il segnale con un numero relativo alla vita del player, e 
#in base al numero estratto cambierà la suddetta foto png schifosa della vita
func change_afterlife(value: int):
	change_panel_texture(texture_path[value])
	
func change_panel_texture(new_texture: String):
	var style2 : StyleBoxTexture = StyleBoxTexture.new()
	style2.texture = load(new_texture)
	panel.add_theme_stylebox_override("panel", style2)
