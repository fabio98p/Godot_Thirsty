extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("/root/AudioStreamPlayer2d").playing = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
