extends CanvasLayer

@onready var scoreText = $egik
@onready var deathText = $death

var direction = Input.get_axis("left", "right")

func _ready():
	set_death(Global.restart_count)

func set_score(n: int):
	scoreText.text = "EZIK: %d" % n

func set_death(n: int):
	deathText.text = "DEATH: %d" % n
	
