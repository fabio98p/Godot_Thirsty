extends Node2D
@onready var player: CharacterBody2D = $Player

@export var player_position: Vector2 = Vector2(531, 530)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.position = player_position 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
