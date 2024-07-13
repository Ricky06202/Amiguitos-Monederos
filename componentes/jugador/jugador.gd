@tool
extends CharacterBody2D

@export var transformacion_actual: Transformacion:
	set(t):
		transformacion_actual = t
		inicializar()

@export var move_speed: float
@export var jump_speed: float
@onready var animacion: AnimatedSprite2D = get_node("Animacion")
@onready var colision: CollisionShape2D = get_node("Colision")
var is_facing_right = true
var gravedad = ProjectSettings.get_setting("physics/2d/default_gravity")

func inicializar():
	if animacion:
		animacion.sprite_frames = transformacion_actual.animacion
		animacion.play("Quieto")
		animacion.flip_h = transformacion_actual.hay_que_volterarla
		animacion.position = transformacion_actual.posicion_animacion
		animacion.scale = Vector2(transformacion_actual.escala, transformacion_actual.escala)
	if colision:
		var capsula = colision.shape as CapsuleShape2D
		capsula.radius = transformacion_actual.radio
		capsula.height = transformacion_actual.altura
		colision.position = transformacion_actual.posicion_colision
		colision.rotation_degrees = transformacion_actual.rotacion

var esta_en_el_mundo = false

func _ready():
	inicializar()
	esta_en_el_mundo = true

func _physics_process(delta):
	if not esta_en_el_mundo: return
	update_animations()
	flip()
	#cuando estamos ejecutando el juego
	if not Engine.is_editor_hint():
		jump()
		move_x()
		aplicar_gravedad(delta)
		
	#cuando estamos editando el juego
	if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and  Engine.is_editor_hint():
		aplicar_gravedad(delta)
	move_and_slide()

func update_animations():
	if not is_on_floor():
		if velocity.y < 0:
			if animacion.sprite_frames.has_animation("Saltar"):
				animacion.play("Saltar")
		else:
			if animacion.sprite_frames.has_animation("Caer"):
				animacion.play("Caer")
		return
	if velocity.x:
		if animacion.sprite_frames.has_animation("Avanzar"):
			animacion.play("Avanzar")
	else:
		if animacion.sprite_frames.has_animation("Quieto"):
			animacion.play("Quieto")

func flip():
	if is_facing_right and velocity.x < 0 or (not is_facing_right and velocity.x > 0):
		scale.x *= - 1
		is_facing_right = not is_facing_right

func move_x():
	var input_axis = Input.get_axis("Izquierda", "Derecha")
	velocity.x = input_axis * move_speed

func jump():
	if Input.is_action_just_pressed("Saltar") and is_on_floor():
		velocity.y = -jump_speed
	
func aplicar_gravedad(delta):
	if not is_on_floor():
		velocity.y += gravedad * delta