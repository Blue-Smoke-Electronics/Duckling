extends Node2D

const LVL_WATER = preload("res://levels/water/lvl_water.tscn")

func _on_area_2d_level_compleated_body_entered(body):
	if body is Player:
		get_tree().change_scene_to_packed(LVL_WATER)
