extends Resource
class_name Transformacion

@export var nombre: String
@export var animacion: SpriteFrames
@export var hay_que_volterarla: bool
@export var posicion_animacion: Vector2
@export var escala: float = 1

@export_category("Colision")
@export var radio: float
@export var altura: float
@export var posicion_colision: Vector2
@export var rotacion: int

@export_category("Habilidades")
@export var cantidad_saltos: int
@export var puede_saltar_en_las_paredes: bool = false