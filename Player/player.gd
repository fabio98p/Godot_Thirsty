extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var hp_max := 3
var current_hp = hp_max
var isInvincible := false
@onready var inv_frame_timer: Timer = $InvFrameTimer

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("left", "right", "forward", "back")
	if direction:
		self.velocity = direction * SPEED
	else:
		self.velocity = Vector2.ZERO
	if Input.is_action_pressed("jump"):
		lose_hp()
		
	print(current_hp, isInvincible)
	move_and_slide()
	
func lose_hp():
	if !isInvincible:
		current_hp = current_hp-1
		inv_frame_timer.start()
		isInvincible = true

func _on_inv_frame_timer_timeout() -> void:
	isInvincible = false
