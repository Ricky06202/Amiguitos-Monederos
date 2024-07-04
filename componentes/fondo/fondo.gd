@tool
extends ParallaxBackground

@onready var nodo_color: ColorRect = get_node("ColorRect")
@onready var nodo_imagen: Sprite2D = get_node("ParallaxLayer/Sprite2D")

@export var color_fondo: Color:
	set(c):
		color_fondo = c
		if nodo_color:
			inicializar_color()
@export var imagen_fondo: Texture2D:
	set(i):
		imagen_fondo = i
		if nodo_imagen:
			inicializar_imagen()
# Called when the node enters the scene tree for the first time.
func _ready():
	inicializar()

func inicializar():
	inicializar_color()
	inicializar_imagen()

func inicializar_color():
	nodo_color.color = color_fondo

func inicializar_imagen():
	nodo_imagen.texture = imagen_fondo
