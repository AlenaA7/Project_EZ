extends Control

var game = preload("res://main.tscn")

func _on_ded_pressed():
	get_tree().change_scene_to_packed(game)
	Global.player_style = 0
 # Replace with function body.

func _on_hero_pressed():
	get_tree().change_scene_to_packed(game)
	Global.player_style = 1
# Replace with function body.

func _on_info_pressed():
	var control = load("res://control.tscn")
	get_tree().change_scene_to_packed(control)


func _process(_delta):
	if Input.is_action_just_pressed("secret"):
		Global.player_style = 2
		get_tree().change_scene_to_packed(game)





