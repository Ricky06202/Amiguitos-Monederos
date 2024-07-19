@tool
extends CharacterBody2D

@export var gravedad_en_editor := true:
	set(value):
		gravedad_en_editor = value
		velocity = Vector2()
		move_and_slide() 

@export var enemigo: Enemigo:
	set(e):
		enemigo = e
		inicializar()

@export var move_speed: float
@export var empezar_hacia_la_derecha:= true:
	set(e):
		empezar_hacia_la_derecha = e
		direction = empezar_hacia_la_derecha
		is_facing_right = empezar_hacia_la_derecha

@onready var hitbox : Hitbox= get_node("Hitbox")
@onready var hurtbox : Hurtbox= get_node("Hurtbox")

var direction := 1
@onready var animacion = get_node("EnemySprite")
@onready var colision = get_node("EnemyCollision")
var is_facing_right = true
var gravedad = ProjectSettings.get_setting("physics/2d/default_gravity")

func inicializar():
	move_speed = enemigo.velocidad
	if animacion:
		animacion.sprite_frames = enemigo.animacion
		animacion.play("Avanzar")
		animacion.flip_h = enemigo.hay_que_volterarla
		animacion.position = enemigo.posicion_animacion
	if colision:
		colision.shape = CapsuleShape2D.new()
		var capsula = colision.shape as CapsuleShape2D
		capsula.radius = enemigo.radio
		capsula.height = enemigo.altura
		colision.position = enemigo.posicion_colision
		colision.rotation_degrees = enemigo.rotacion

func _ready():
	inicializar()

func _physics_process(delta):
	if not hemos_muerto:
		update_animations_enemy()
		flip_enemy()
	#cuando estamos ejecutando el juego
	if not Engine.is_editor_hint():
		if not hemos_muerto:
			move_enemy()	
		else:
			velocity.x = 0
		aplicar_gravedad(delta)
		move_and_slide() 

	#cuando estamos editando el juego
	if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and Engine.is_editor_hint() and not is_instance_of(get_parent(), SubViewport) and gravedad_en_editor:
		aplicar_gravedad(delta)
		move_and_slide() 

	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and Engine.is_editor_hint():
		velocity = Vector2()
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

	velocity.x = direction * move_speed

func aplicar_gravedad(delta):
	if not is_on_floor():
		velocity.y += gravedad * delta

var hemos_muerto := false
func _on_vida_sin_vida():
	morir()

func morir():
	hemos_muerto = true
	hitbox.queue_free()
	hurtbox.queue_free()
	animacion.play("Sufrir")
	var tween := get_tree().create_tween()
	tween.tween_property(animacion, "modulate", Color.TRANSPARENT, 1)
	await tween.finished
	Estado.enemigo_derrotado.emit()
	queue_free()