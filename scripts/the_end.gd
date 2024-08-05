extends Area2D

func _on_body_entered(body):
	if body is Player:
		body._on_the_end()
		
 # Replace with function body.
#Конец игрф
#НЕ РАБОТАЕТ КОЛИЗИЯ У THE_END
