extends Node2D

class_name Bullet
var bullet_sprite: Texture
@export var speed: float = 100
@onready var timer: Timer = $Timer
@onready var sprite_2d: Sprite2D = $Sprite2D

signal playerHit

func _ready() -> void:
	get_tree().get_root().get_node("Level_city").connectToPlayerHit(self)
	sprite_2d.texture = bullet_sprite
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += transform.x * speed * delta


func _on_kill_timer_timeout() -> void:
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("ciao bullet")
