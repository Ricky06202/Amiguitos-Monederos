extends CharacterBody2D

@export var move_speed: float
var direction: float
@onready var enemy_sprite = $EnemySprite
var is_facing_right = true
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	update_animations_enemy()
	flip_enemy()
	move_enemy(delta)	
	move_and_slide() 

func update_animations_enemy():
	if velocity.x:
		enemy_sprite.play("Move")
	else:
		enemy_sprite.play("Idle")

func flip_enemy():
	if is_facing_right and velocity.x < 0 or (not is_facing_right and velocity.x > 0): 
		scale.x *= -1
		is_facing_right = not is_facing_right

func move_enemy(delta):
	if is_on_wall() or not $LeftCollision.is_colliding() or not $RightCollision.is_colliding():
		direction = -direction
	elif velocity.x > 0:
		direction = 1
	else:
		direction = -1
	
	velocity.x = direction * move_speed
	velocity.y += gravity * delta
