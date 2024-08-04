class_name Coin
extends Node2D

signal  picked_up


func _on_area_2d_body_entered(_body):
	picked_up.emit()
	queue_free()
