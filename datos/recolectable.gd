@tool
extends Resource
class_name Recolectable

@export var animacion: SpriteFrames
@export var escala: float = 1
@export var posicionY: int = 0
@export var esDinero: bool = false
@export var valor: int

@export_category("Transformacion")
var es_una_habilidad: bool = !!transformacion
@export var transformacion: Transformacion:
	set(nueva):
		transformacion = nueva
		es_una_habilidad = !!transformacion
		animacion = transformacion.animacion

