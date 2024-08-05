extends Area2D
@onready var sprite = $AnimatedSprite2D

func _on_body_entered(body):
	if body is Player:
		body._on_the_end()
		sprite.play('happy')
		$Timer.start()
	
	
func _on_timer_timeout():
	get_tree().change_scene_to_file("res://menu.tscn")
		
		
 # Replace with function body.
#Конец игрф
#НЕ РАБОТАЕТ КОЛИЗИЯ У THE_END
