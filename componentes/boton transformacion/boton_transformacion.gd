@tool
extends Button

@export var transformacion: Transformacion:
	set(t):
		transformacion = t
		inicializar()

@onready var animacion : AnimatedSprite2D= get_node("animacion")
@onready var nombre : Label= get_node("nombre")

func inicializar():
	if animacion:
		animacion.sprite_frames = transformacion.animacion
		animacion.animation = "Quieto"
		animacion.flip_h = transformacion.hay_que_volterarla
		animacion.play()
	if nombre:
		nombre.text = transformacion.nombre

func _ready():
	inicializar()

func _on_mouse_exited():
	if animacion:
		animacion.animation = "Quieto"

func _on_mouse_entered():
	if animacion:
		animacion.animation = "Avanzar"

func _on_pressed():
	Estado.cambiar_transformacion.emit(transformacion)
