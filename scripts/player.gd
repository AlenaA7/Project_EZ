class_name Player

extends CharacterBody2D

const SPEED = 100.0
const RUN_SPEED = 1000.0
const  SPEED_ON_LESTICA = 100
const JUMP_VELOCITY = -250.0


# Get the gravity from the project settings to be synced with RigidBody nodes.
@export var id = 1
@export var pushForce = 51000
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var count_jump = 2
var ladders = {}
@onready var styles = [$ne_Buy, $Superman, $Buy]
var sprite: AnimatedSprite2D 



func _ready():
	for style in styles:
		style.visible = false
	sprite = styles[Global.player_style]
	sprite.visible = true


func on_lestica(value: bool, ladder_id: int):
	ladders[ladder_id] = value
	
func is_on_lestnitsa() -> bool:
	for ladder_id in ladders:
		if ladders[ladder_id]:
			return true
	return false


func _process(_delta):
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()


func _physics_process(delta):
#СДЕЛАТЬ ИНТЕРЕСНУЮ СМЕРТЬ
	#if Global.dead: 
		#velocity.y = JUMP_VELOCITY

	
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
		sprite.play("stop")
	
	
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
		
	if not is_on_floor():
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
				
	

	








