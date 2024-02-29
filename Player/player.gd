class_name Player
extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const MAX_HOLD_TIME  =2
const MAX_JUMPS = 5

@export var enable_jump = false
@export var movement_curve : Curve

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var hold_time : float = 0
var jump_cnt : int = 0

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if enable_jump: 
		# Handle jump.
		if Input.is_action_just_pressed("jump") and jump_cnt < MAX_JUMPS:
			velocity.y = JUMP_VELOCITY
			jump_cnt += 1
		if is_on_floor():
			jump_cnt = 0

	if Input.is_action_pressed("left"): 
		hold_time -= delta
	elif Input.is_action_pressed("right"):
		hold_time += delta
	else:
		hold_time -= sign(hold_time)*delta*0.3
		
	hold_time = clamp(hold_time,-MAX_HOLD_TIME,MAX_HOLD_TIME)	
	
	var movment = movement_curve.sample((hold_time/MAX_HOLD_TIME)/2+0.5)
	
	if Input.is_action_pressed("left"): 
		velocity.x = movment * SPEED
	elif Input.is_action_pressed("right"):
		velocity.x = movment * SPEED
	else :
		velocity.x =0
		
	print((hold_time/MAX_HOLD_TIME)/2+0.5, " : ", movement_curve.sample((hold_time/MAX_HOLD_TIME)/2+0.5))
	
	rotation = hold_time/MAX_HOLD_TIME*PI
	
	
	
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = Input.get_axis("left", "right")
	#if direction:
	#	velocity.x = direction * SPEED
	#else:
	#	velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
