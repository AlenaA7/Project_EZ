extends Area2D

@onready var sprite = $AnimatedSprite2D


func _on_body_entered(body):
	if body is Player:
		print('happy')
		body._on_the_end()
		sprite.play('happy')
		
