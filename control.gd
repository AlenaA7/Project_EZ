extends Control

var menu = preload("res://menu.tscn")

func _on_home_pressed():
	get_tree().change_scene_to_packed(menu)

