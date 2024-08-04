extends Node2D

@export var id = 1
@export var main: Main

const JUMP_VELOCITY = -250.0
var should_restart = false

func _process(_delta):
	if should_restart:
		main.on_death()
		
		get_tree().reload_current_scene()

func _on_body_entered(body):
	if body is Player:
		$killtime.start()
		body._on_dead()
	

func _on_killtime_timeout():
	should_restart = true
