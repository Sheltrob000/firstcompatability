extends CharacterBody2D


const SPEED = 20000
const JUMP_VELOCITY = -400.0

var direction = -1
var canTurn := true






func _physics_process(delta: float) -> void:
	## Add the gravity.
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		velocity.x = direction * SPEED * delta	
		
	if (!$floorLeft.is_colliding() or !$floorRight.is_colliding()) and canTurn:
		velocity.x *= -1
		$Sprite2D.flip_h = !$Sprite2D.flip_h
		canTurn = false
		$turntimer.start()
		
	if is_on_wall() and canTurn:
		direction *= -1
		$Sprite2D.flip_h = !$Sprite2D.flip_h
		canTurn = false
		$turntimer.start()
	
 
	if velocity.x == 0:
		velocity.x = direction * SPEED * delta	

	move_and_slide()


func _on_turn_timer_timeout() -> void:
	canTurn = true
