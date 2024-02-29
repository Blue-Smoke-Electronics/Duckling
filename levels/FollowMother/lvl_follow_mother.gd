extends Node2D

# Called when the node enters the scene tree for the first time.
const LVL_JUMP = preload("res://levels/jump/lvl_jump.tscn")

func _on_area_2d_level_compleated_body_entered(body):
	if body is Player:
		get_tree().change_scene_to_packed(LVL_JUMP)

