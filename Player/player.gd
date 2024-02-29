class_name Player
extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const MAX_HOLD_TIME  =2
const JUMP_CNT = 5
const MAX_JUMP_TIME = 1

@export var enable_jump = false
@export var movement_curve : Curve
@export var jump_curve : Curve


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var hold_time : float = 0

var jump_time : float = 0
var jump_cnt : int = 0

var submerged = false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor() :
		if not submerged:
			velocity.y += gravity * delta
		else : 
			velocity.y += gravity/100 * delta

	if enable_jump: 
		# Handle jump.
		if Input.is_action_just_pressed("jump") and jump_cnt < JUMP_CNT:
			velocity.y = JUMP_VELOCITY *jump_curve.sample(jump_time/MAX_JUMP_TIME)
			if submerged:
				velocity.y *= 0.2
			print(jump_time/MAX_JUMP_TIME)
			jump_cnt += 1
			jump_time = 0
		else:
			jump_time += delta
			
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
		
	#print((hold_time/MAX_HOLD_TIME)/2+0.5, " : ", movement_curve.sample((hold_time/MAX_HOLD_TIME)/2+0.5))
	
	rotation = hold_time/MAX_HOLD_TIME*PI

	if submerged:
		velocity.x *= 0.3
	move_and_slide()

func enter_water():
	submerged = true
	velocity.y = 0
	
func leave_water():
	submerged = false
	velocity.y = -300
