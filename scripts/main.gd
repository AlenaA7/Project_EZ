class_name Main
extends Node2D

var score = 0

@onready var coins = $coins
@onready var hud = $hud

func _ready():
	for coin in coins.get_children():
		if coin is Coin:
			coin.picked_up.connect(_on_coin_picked_up)
		
func _on_coin_picked_up():
	score += 1
	hud.set_score(score)
	

func on_death():
	Global.restart_count += 1
	hud.set_death(Global.restart_count)
	
func _process(_delta):
	if Input.is_action_just_pressed("exit"):
		get_tree().change_scene_to_file("res://menu.tscn")

