extends Node2D

@export var bullet_scene: PackedScene
@onready var shoot_rate_spawn_timer: Timer = $Shoot_rate_spawn_timer
@onready var rotator_bullets: Node2D = $Rotator_bullets


const rotate_speed = 100
const shoot_timer_wait_time = 0.2
const spawn_point_count = 4
const radius = 100

func _ready():	
	var step = 2 * PI / spawn_point_count
	
	for i in range(spawn_point_count):
		var spawn_point = Node2D.new()
		var pos = Vector2(radius, 0).rotated(step * i)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		rotator_bullets.add_child(spawn_point)
		
	shoot_rate_spawn_timer.wait_time = shoot_timer_wait_time
	shoot_rate_spawn_timer.start()


func _process(delta):
	var new_rotation = rotator_bullets.rotation_degrees + rotate_speed * delta
	rotator_bullets.rotation_degrees = fmod(new_rotation, 360)
	
func _on_shoot_rate_spawn_timer_timeout() -> void:
	for s in rotator_bullets.get_children():
		var bullet = bullet_scene.instantiate()
		get_parent().get_node("Bullets").add_child(bullet)
		bullet.position = s.global_position
		bullet.rotation = s.global_rotation	
