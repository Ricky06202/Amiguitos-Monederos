@tool
extends CharacterBody2D

@export var enemigo: Enemigo:
	set(e):
		enemigo = e
		inicializar()

@export var move_speed: float
var direction: float
@onready var animacion = get_node("EnemySprite")
@onready var colision = get_node("EnemyCollision")
var is_facing_right = true
var gravedad = ProjectSettings.get_setting("physics/2d/default_gravity")

func inicializar():
	if animacion:
		animacion.sprite_frames = enemigo.animacion
		animacion.play("Quieto")
		animacion.flip_h = enemigo.hay_que_volterarla
		animacion.position = enemigo.posicion_animacion
	if colision:
		var capsula = colision.shape as CapsuleShape2D
		capsula.radius = enemigo.radio
		capsula.height = enemigo.altura
		colision.position = enemigo.posicion_colision
		colision.rotation_degrees = enemigo.rotacion

func _ready():
	inicializar()

func _physics_process(delta):
	update_animations_enemy()
	flip_enemy()
	#cuando estamos ejecutando el juego
	if not Engine.is_editor_hint():
		move_enemy()	
		aplicar_gravedad(delta)
		move_and_slide() 

	#cuando estamos editando el juego
	if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and  Engine.is_editor_hint() and not is_instance_of(get_parent(), SubViewport):
		aplicar_gravedad(delta)
		move_and_slide() 

func update_animations_enemy():
	if velocity.x:
		if animacion.sprite_frames.has_animation("Avanzar"):
			animacion.play("Avanzar")
	else:
		if animacion.sprite_frames.has_animation("Quieto"):
			animacion.play("Quieto")

func flip_enemy():
	if is_facing_right and velocity.x < 0 or (not is_facing_right and velocity.x > 0): 
		scale.x *= -1
		is_facing_right = not is_facing_right

func move_enemy():
	if is_on_wall() or not $LeftCollision.is_colliding() or not $RightCollision.is_colliding():
		direction = -direction
	elif velocity.x > 0:
		direction = 1
	else:
		direction = -1
	
	velocity.x = direction * move_speed

func aplicar_gravedad(delta):
	if not is_on_floor():
		velocity.y += gravedad * delta
