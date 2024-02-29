extends Node2D



# Called when the node enters the scene tree for the first time.


func _on_area_2d_level_compleated_body_entered(body):
	if body is Player:
		get_tree().quit()
