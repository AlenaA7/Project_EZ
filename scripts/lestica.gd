#class_name Lestica

extends Area2D 

func _on_body_entered(body):
	if body is Player:
		body.on_lestica(true, get_instance_id())

func _on_body_exited(body):
	if body is Player:
		body.on_lestica(false, get_instance_id())
