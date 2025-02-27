extends CharacterBody2D


const SPEED = 100000.0
const JUMP_VELOCITY = -150000.0
const DASH_SPEED = 500000
var candoublejump = true
var dashDirection = true
var isdashing = false
var candash = true


func dash(direction :int):
	if candash:
		isdashing = true
		candash = false
		$"../dashtimer".start()
		$"../CanDashTimer".start()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY * delta
		
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y = 0
	
	if is_on_floor():
		candoublejump = true
	
	if Input.is_action_just_pressed("jump") and !is_on_floor() and candoublejump:
		velocity.y = JUMP_VELOCITY * delta
		candoublejump = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	var directionvert := Input.get_axis("up", "down")
	
	if isdashing:
		velocity.x = direction * DASH_SPEED * delta
		velocity.y = directionvert * DASH_SPEED *delta
		skew = direction
	else:
		velocity.x = direction * SPEED * delta
		skew = direction * .5
	
	if Input.is_action_just_pressed("dash"):
		dash(direction)

	move_and_slide()


func _on_dashtimer_timeout() -> void:
	isdashing = false
	velocity.y = 0
	velocity.x = 0

func _on_can_dash_timer_timeout() -> void:
	candash = true
