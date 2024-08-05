class_name Player

extends CharacterBody2D

const SPEED = 100.0
const RUN_SPEED = 1000.0
const  SPEED_ON_LESTICA = 100
const JUMP_VELOCITY = -250.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
@export var main: Main

@export var pushForce = 51000
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var count_jump = 2
var ladders = {}
@onready var styles = [$ne_Buy, $Superman, $Buy]
var sprite: AnimatedSprite2D 
var is_dead = false
var the_end = false
@onready var text_the_end = $"../texts/the end"

func _ready():
	for style in styles:
		style.visible = false
	sprite = styles[Global.player_style]
	sprite.visible = true

func _on_dead():
	is_dead = true
	get_node("CollisionShape2D").queue_free()
	velocity.y = JUMP_VELOCITY * 1.5

func _on_the_end():
	the_end = true

func on_lestica(value: bool, ladder_id: int):
	ladders[ladder_id] = value
	
func is_on_lestnitsa() -> bool:
	for ladder_id in ladders:
		if ladders[ladder_id]:
			return true
	return false

func _process(_delta):
	if Input.is_action_just_pressed("reset"):
		#main.on_death()
		get_tree().reload_current_scene()
		
func _physics_process(delta):
	if is_dead:
		dead_process(delta)
	elif the_end:
		end_process(delta) 
	else:
		life_process(delta)
		
func end_process(delta):
	sprite.play('happy')
	velocity.x = 0
	velocity.y = 0
	text_the_end.visible = true
	$Timer.start()
	
	
func _on_timer_timeout():
	text_the_end.visible = false
	get_tree().change_scene_to_file("res://menu.tscn")

func dead_process(delta):
	velocity.x = 0
	sprite.play("dead")
	velocity.y += gravity * delta
	move_and_slide()
	
		

func life_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump"):	
		if count_jump > 0:
			velocity.y = JUMP_VELOCITY
			count_jump -= 1
		else:
			velocity.y += gravity * delta
				
		
	if 	is_on_lestnitsa():
		if Input.is_action_pressed("up"):
			velocity.y = -SPEED_ON_LESTICA 
		elif Input.is_action_pressed("down"):
			velocity.y = SPEED_ON_LESTICA 
		else:
			velocity.y = 0
	
	
	if Input.is_action_just_pressed("jump") and is_on_floor() and not is_on_lestnitsa():
		velocity.y = JUMP_VELOCITY	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
		
	#if Input.is_action_just_pressed("running") and is_on_floor():
		#velocity.x = direction * RUN_SPEED
		#print("run")
		
	if direction < 0:
		sprite.flip_h = true
	if direction > 0:
		sprite.flip_h = false
		
	if is_on_lestnitsa():
		sprite.play('on_ladder')
	elif not is_on_floor():
		sprite.play("jump")	
	else:
		count_jump = 1
		if direction == 0:
			sprite.play("stop")
		else:
			sprite.play("run")

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = 0 # move_toward(velocity.x, 0, SPEED)

	if move_and_slide():
		for i in get_slide_collision_count():
			var col = get_slide_collision(i)
			if col.get_collider() is RigidBody2D:
				var dir = col.get_normal().rotated(-direction * PI/4) * - pushForce
				col.get_collider().apply_force(dir)
		












