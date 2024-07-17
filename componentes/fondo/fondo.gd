@tool
extends ParallaxBackground

@onready var nodo_color_cielo: ColorRect = get_node("ColorRect")
@onready var nodo_color_tierra: ColorRect = get_node("ColorRect2")
@onready var nodo_imagen: Sprite2D = get_node("ParallaxLayer/Sprite2D")

@export var color_cielo: Color:
	set(c):
		color_cielo = c
		if nodo_color_cielo:
			inicializar_color_cielo()

@export var color_tierra: Color:
	set(c):
		color_tierra = c
		if nodo_color_tierra:
			inicializar_color_cielo()
			
@export var imagen_fondo: Texture2D:
	set(i):
		imagen_fondo = i
		if nodo_imagen:
			inicializar_imagen()
# Called when the node enters the scene tree for the first time.
func _ready():
	inicializar()

func inicializar():
	inicializar_color_cielo()
	inicializar_color_tierra()
	inicializar_imagen()

func inicializar_color_cielo():
	nodo_color_cielo.color = color_cielo

func inicializar_color_tierra():
	nodo_color_tierra.color = color_tierra

func inicializar_imagen():
	nodo_imagen.texture = imagen_fondo
