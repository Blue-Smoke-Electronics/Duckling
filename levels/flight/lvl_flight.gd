extends Node2D



func _on_area_2d_level_compleated_body_entered(body):
	if body is Player:
		get_tree().quit()

