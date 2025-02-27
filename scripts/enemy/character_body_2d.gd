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
	if (!$RayCast2D.is_colliding() or !$RayCast2D2.is_colliding()) and canTurn:
		velocity.x *= -1
		$Sprite2D.flip_h = !$Sprite2D.flip_h
		canTurn = false

	if ($RayCast2D3.is_colliding() or $RayCast2D4.is_colliding()) and canTurn:
		velocity.x *= -1
		$Sprite2D.flip_h = !$Sprite2D.flip_h
		canTurn = false

	if velocity.x == 0:
		velocity.x = direction * SPEED * delta	
	
	if canTurn:
		print("canturn")

	
	



	move_and_slide()


func _on_timer_timeout() -> void:
	canTurn = true