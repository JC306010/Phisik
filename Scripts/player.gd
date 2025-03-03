extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -300.0
var JUMP_COUNTER = 0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if is_on_floor():
		JUMP_COUNTER = 0
	# Handle double jump
	if Input.is_action_just_pressed("jump") and JUMP_COUNTER <= 1: 
		velocity.y = JUMP_VELOCITY + 100
		JUMP_COUNTER = JUMP_COUNTER + 1
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor(): 
		velocity.y = JUMP_VELOCITY
		JUMP_COUNTER = 1
	var direction := Input.get_axis("move_left", "move_right")
	# Flips character to face movment
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
