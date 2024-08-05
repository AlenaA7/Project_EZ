class_name Coin
extends Node2D

signal  picked_up

@onready var sound = $AudioStreamPlayer

func _on_area_2d_body_entered(_body):
	picked_up.emit()
	sound.play()
	queue_free()
