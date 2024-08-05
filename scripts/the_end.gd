extends Area2D
@onready var sprite = $AnimatedSprite2D
@onready var happy_musics = [$ne_buy, $ne_buy,$buy ]

var happy_music: AudioStreamPlayer

func _ready():
	happy_music = happy_musics[Global.player_style]

func _on_body_entered(body):
	happy_music.play()
	if body is Player:
		body._on_the_end()
		sprite.play('happy')
		$Timer.start()
	
	
func _on_timer_timeout():
	get_tree().change_scene_to_file("res://menu.tscn")
		
		
 # Replace with function body.
#Конец игрф
#НЕ РАБОТАЕТ КОЛИЗИЯ У THE_END
