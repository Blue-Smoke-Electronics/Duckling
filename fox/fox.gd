extends Area2D

@export var target :Player

const SPEED  = 200
@onready var timer = $Timer
var velocity : float = 0

func _physics_process(delta):
	if is_instance_valid(target):
		velocity = SPEED * (target.position-position).normalized().x
	
	position.x += velocity*delta
	


func _on_body_entered(body):
	if body is Player:
		body.queue_free()
	timer.start()
	


func _on_timer_timeout():
	get_tree().quit()
