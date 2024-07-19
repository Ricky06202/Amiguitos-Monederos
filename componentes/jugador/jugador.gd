@tool
extends CharacterBody2D

@export var gravedad_en_editor := true:
	set(value):
		gravedad_en_editor = value
		velocity = Vector2()
		move_and_slide() 

@export var transformacion_actual: Transformacion = preload("res://datos/transformaciones/Humano.tres"):
	set(t):
		transformacion_actual = t
		inicializar()

var saltos_realizados := 0

@onready var hitbox : Hitbox= get_node("Hitbox")
@onready var hurtbox : Hurtbox= get_node("Hurtbox")

@export var move_speed: float = 100
@export var jump_speed: float = 300
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


func _ready():
	if Engine.is_editor_hint(): return
	inicializar()
	Estado.cambiar_transformacion.connect(al_cambiar_transformacion)
	set_physics_process(true)

func al_cambiar_transformacion(transformacion: Transformacion):
	transformacion_actual = transformacion

func _physics_process(delta):
	if is_instance_of(get_parent(), SubViewport):
		animacion.play("Quieto")
		set_physics_process(false)
		return
	
	if not hemos_muerto:
		update_animations()
		flip()
	#cuando estamos ejecutando el juego
	if not Engine.is_editor_hint():
		if not hemos_muerto:
			jump()
			move_x()
		else:
			if is_on_floor():
				velocity.x = 0
		aplicar_gravedad(delta)
		move_and_slide()
		
	#cuando estamos editando el juego
	if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and Engine.is_editor_hint() and not is_instance_of(get_parent(), SubViewport):
		aplicar_gravedad(delta)
		move_and_slide()

	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and Engine.is_editor_hint():
		velocity = Vector2()
		move_and_slide() 

func update_animations():
	if not is_on_floor():
		if esta_agarrado_de_la_pared:
			if animacion.sprite_frames.has_animation("Parkour"):
				animacion.play("Parkour")

		elif velocity.y < 0:
			if animacion.sprite_frames.has_animation("Saltar"):
				animacion.play("Saltar")
		else:
			if animacion.sprite_frames.has_animation("Caer"):
				animacion.play("Caer")

	elif velocity.x:
		if animacion.sprite_frames.has_animation("Avanzar"):
			animacion.play("Avanzar")
	else:
		if animacion.sprite_frames.has_animation("Quieto"):
			animacion.play("Quieto")

func flip():
	if is_facing_right and velocity.x < 0 or (not is_facing_right and velocity.x > 0):
		scale.x *= - 1
		is_facing_right = not is_facing_right

var input_axis

func move_x():
	input_axis = Input.get_axis("Izquierda", "Derecha")
	velocity.x = input_axis * move_speed

var esta_agarrado_de_la_pared = true

var pared_actual

func ya_se_agarro_de_esa_pared(): return pared_actual == input_axis and ha_saltado

#todo hacer componentes en forma de nodos para las habilidades, para asi hacerlo escalable
func jump():
	if transformacion_actual.puede_saltar_en_las_paredes and is_on_wall() and input_axis != 0:
		pared_actual = input_axis
		esta_agarrado_de_la_pared = true
	if is_on_floor() or transformacion_actual.puede_saltar_en_las_paredes and esta_agarrado_de_la_pared:
		saltos_realizados = 0
	if transformacion_actual.cantidad_saltos == 0 or not (saltos_realizados < transformacion_actual.cantidad_saltos) : return
	if Input.is_action_just_pressed("Saltar") and is_on_floor() or Input.is_action_just_pressed("Saltar") and not is_on_floor():
		velocity.y = -jump_speed
		saltos_realizados += 1

var ha_saltado = false

func aplicar_gravedad(delta):
	if transformacion_actual.puede_saltar_en_las_paredes:
		if not is_on_floor() and not esta_agarrado_de_la_pared or ya_se_agarro_de_esa_pared():
			velocity.y += gravedad * delta
			ha_saltado = false
		else: #esta agarrado de la pared
			if not Input.is_action_just_pressed("Saltar") and not ha_saltado and not is_on_floor():
				velocity = Vector2()
			else:
				ha_saltado = true
				esta_agarrado_de_la_pared = false

	elif not is_on_floor():
		velocity.y += gravedad * delta

var hemos_muerto:= false

func _on_vida_sin_vida():
	hemos_muerto = true
	hitbox.queue_free()
	hurtbox.queue_free()
	transformacion_actual = preload("res://datos/transformaciones/Humano.tres")
	animacion.play("Sufrir")
	var tween := get_tree().create_tween()
	tween.tween_property(animacion, "modulate", Color.TRANSPARENT, 1)
	await tween.finished
	Estado.perder.emit()



func _on_hitbox_realizar_dano():
	velocity.y = -jump_speed
	saltos_realizados = 0
