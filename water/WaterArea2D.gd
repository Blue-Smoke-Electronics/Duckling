class_name Water
extends Area2D



func _on_body_entered(body):
	if body is Player:
		body.enter_water()

func _on_body_exited(body):
	if body is Player:
		body.leave_water()
