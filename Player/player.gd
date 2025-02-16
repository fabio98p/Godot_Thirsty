extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var hp_max := 3
var current_hp = hp_max

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("left", "right", "forward", "back")
	if direction:
		self.velocity = direction * SPEED
	else:
		self.velocity = Vector2.ZERO

	move_and_slide()
