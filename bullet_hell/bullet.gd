extends Node2D

class_name Bullet
@export var speed: float = 100
@onready var timer: Timer = $Timer

signal playerHit

func _ready() -> void:
	get_tree().get_root().get_node("Level1").connectToPlayerHit(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += transform.x * speed * delta


func _on_kill_timer_timeout() -> void:
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("ciao bullet")
