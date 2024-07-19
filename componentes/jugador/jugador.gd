@tool
extends CharacterBody2D

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

func update_animations():
	if not is_on_floor():
		if transformacion_actual.puede_saltar_en_las_paredes and is_on_wall_only():
			if animacion.sprite_frames.has_animation("Saltar"):
				animacion.play("Saltar")

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

#todo hacer componentes en forma de nodos para las habilidades, para asi hacerlo escalable
func jump():
	if is_on_floor() or transformacion_actual.puede_saltar_en_las_paredes and is_on_wall_only():
		saltos_realizados = 0
	if transformacion_actual.cantidad_saltos == 0 or not (saltos_realizados < transformacion_actual.cantidad_saltos) : return
	if Input.is_action_just_pressed("Saltar") and is_on_floor() or Input.is_action_just_pressed("Saltar") and not is_on_floor():
		velocity.y = -jump_speed
		saltos_realizados += 1
	
func aplicar_gravedad(delta):
	if not is_on_floor() or transformacion_actual.puede_saltar_en_las_paredes:
		velocity.y += gravedad * delta
<<<<<<< Updated upstream

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
	Estado.perdimos.emit()



func _on_hitbox_realizar_dano():
	velocity.y = -jump_speed
	saltos_realizados = 0
=======
>>>>>>> Stashed changes
