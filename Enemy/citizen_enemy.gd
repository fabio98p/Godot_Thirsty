extends Node2D


@export var bullet_scene: PackedScene
@export var bullet_sprite: Texture
@onready var shoot_rate_spawn_timer: Timer = $Timer
@onready var rotator_bullets: Node2D = $Rotetor_cont/Rotator_bullets
@onready var rotetor_cont: Node2D = $Rotetor_cont
@export var level_scene: String

@export var rotate_speed = 100
@export var shoot_timer_wait_time = 0.1
@export var spawn_point_count = 1
@export var radius = 10
@export var fire_angle_rotator = 50
@export var bullet_direction: float = 90
@export var bullet_speed: float = 100
func _ready():	
	#rotator_bullets.rotation = bullet_direction
	rotetor_cont.rotation = bullet_direction
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
	rotator_bullets.rotation_degrees = fmod(new_rotation, fire_angle_rotator)
	rotator_bullets.get_children()[0].rotation = bullet_direction

func _on_timer_timeout() -> void:
	for s in rotator_bullets.get_children():
		var bullet = bullet_scene.instantiate()
		bullet.bullet_sprite = bullet_sprite
		bullet.level_scene = level_scene
		bullet.bullet_speed = bullet_speed
		get_parent().get_node("Bullets").add_child(bullet)
		bullet.position = s.global_position
		bullet.rotation = s.global_rotation	
