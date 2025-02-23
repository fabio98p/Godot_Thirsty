extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var kill_timer: Timer = $Kill_timer

@export var bullet_speed: float = 1500
@export var bullet_sprite: Texture

func _ready() -> void:
	sprite_2d.texture = bullet_sprite
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += transform.y * bullet_speed * delta * -1

func _on_kill_timer_timeout() -> void:
	queue_free()
