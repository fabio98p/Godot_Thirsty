extends Control

@onready var panel: Panel = $Panel
@export var texture_path: Array[String]= []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("jump"):
		print("ciao")
		change_afterlife(1)

#questo script si occuperà solo di una cosa, ovvero captare il segnale con un numero relativo alla vita del player, e 
#in base al numero estratto cambierà la suddetta foto png schifosa della vita
func change_afterlife(value: int):

	change_panel_texture(load("res://Assets/life/life/onelife/h1.png"))
	
func change_panel_texture(new_texture: Texture):
	panel.add_theme_stylebox_override("res://Assets/life/life/onelife/h1.png", StyleBoxTexture)
	
