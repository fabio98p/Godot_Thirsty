extends CharacterBody2D


@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

@onready var mesh_instance_2d_2: MeshInstance2D = $Area2D/MeshInstance2D2
@onready var mesh_instance_2d: MeshInstance2D = $Area2D/MeshInstance2D
@onready var player_hit_particle: CPUParticles2D = $Player_hit_particle
@export var can_fire : bool = false
@export var bullet_scene: PackedScene
@onready var inv_frame_timer: Timer = $InvFrameTimer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var speed_slow = 100.0
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var hp_max := 4
var current_hp = hp_max
var isInvincible := false
signal player_dead
signal player_hit

func _ready() -> void:
	stop_fire()
	while true:
		print("pew")
		print(can_fire)
		if can_fire:
			var bullet = bullet_scene.instantiate()
			add_child(bullet)
		await get_tree().create_timer(0.15).timeout

func stop_fire():
	await get_tree().create_timer(134.4).timeout# 134.4
	can_fire = false
	
func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("left", "right", "forward", "back")
	if direction:
		if Input.is_action_pressed("slow_mode"):
			self.velocity = direction * speed_slow
		else:
			self.velocity = direction * SPEED
	else:
		self.velocity = Vector2.ZERO
	change_animation(direction)	
	move_and_slide()
	
func change_animation(direction: Vector2):
	var animation: String
	if direction.x == 0 && direction.y == 0:
		animation= "idle"
	elif direction.x >= 0.1 :
		animation = "s_run"
		animated_sprite_2d.flip_h = true
	elif direction.x <= -0.1 :
		animation = "s_run"
		animated_sprite_2d.flip_h = false
	elif direction.x == 0 && direction.y >= 0.1:
		animation = "d_run"
	elif direction.x == 0 && direction.y <= -0.1:
		animation = "u_run"
	
	animated_sprite_2d.animation = animation
	
func lose_hp():
	if !isInvincible:
		player_hit_particle.emitting = true
		current_hp = current_hp-1
		audio_stream_player_2d.playing = true
		if current_hp == 0:
			player_dead.emit()
		else:
			inv_frame_timer.start()
			player_hit.emit()
			isInvincible = true
			animated_sprite_2d.modulate.a = 0.5
			await get_tree().create_timer(0.31).timeout
			animated_sprite_2d.modulate.a = 1
			await get_tree().create_timer(0.32).timeout
			animated_sprite_2d.modulate.a = 0.5
			await get_tree().create_timer(0.30).timeout
			animated_sprite_2d.modulate.a = 1
			await get_tree().create_timer(0.28).timeout
			animated_sprite_2d.modulate.a = 0.5
			await get_tree().create_timer(0.26).timeout
			animated_sprite_2d.modulate.a = 1
			await get_tree().create_timer(0.24).timeout
			animated_sprite_2d.modulate.a = 0.5
			await get_tree().create_timer(0.22).timeout
			animated_sprite_2d.modulate.a = 1
		
		
	

func _on_inv_frame_timer_timeout() -> void:
	isInvincible = false

#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("jump"):
		#lose_hp()

func _on_area_2d_area_entered(area: Area2D) -> void:
	lose_hp()
