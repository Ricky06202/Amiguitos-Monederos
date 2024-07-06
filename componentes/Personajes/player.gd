extends CharacterBody2D

@export var move_speed: float
@export var jump_speed: float
@onready var animated_sprite = $PlayerSprite
var is_facing_right = true
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	update_animations()
	jump(delta)
	flip()
	move_x()	
	move_and_slide() 

func update_animations():
	if not is_on_floor():
		if velocity.y < 0:
			animated_sprite.play("Jump")
		else:
			animated_sprite.play("Fall")
		return	
	if velocity.x:
		animated_sprite.play("Run")
	else:
		animated_sprite.play("Idle")

func flip():
	if is_facing_right and velocity.x < 0 or (not is_facing_right and velocity.x > 0): 
		scale.x *= -1
		is_facing_right = not is_facing_right

func move_x():
	var input_axis = Input.get_axis("Move_left","Move_right")
	velocity.x = input_axis * move_speed
	

func jump(delta):
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = -jump_speed
	if not is_on_floor():
		velocity.y += gravity * delta 
