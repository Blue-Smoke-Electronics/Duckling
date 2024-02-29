extends Node2D

const LVL_FLIGHT = preload("res://levels/flight/lvl_flight.tscn")

func _on_area_2d_level_compleated_body_entered(body):
	if body is Player:
		get_tree().change_scene_to_packed(LVL_FLIGHT)

