@tool
extends Panel
class_name Panel_Informativo

@onready var label :Label= get_node("Label")
@onready var sprite :Sprite2D= get_node("Sprite")

@export var texto: String:
	set(valor):
		texto = valor
		inicializar()

@export var imagen: Texture2D:
	set(valor):
		imagen = valor
		inicializar()

@export var hframes: int = 0:
	set(valor):
		hframes = valor
		inicializar()

@export var frame: int = 0:
	set(valor):
		frame = valor
		inicializar()

# Called when the node enters the scene tree for the first time.
func _ready():
	inicializar()
func inicializar():
	if label:
		label.text = texto
	if sprite:
		sprite.texture = imagen
		sprite.hframes = hframes
		sprite.frame = frame