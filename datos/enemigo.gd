extends Resource
class_name Enemigo

@export var animacion: SpriteFrames
@export var hay_que_volterarla: bool
@export var velocidad: int
@export var posicion_animacion: Vector2

@export_category("Colision")
@export var radio: float
@export var altura: float
@export var posicion_colision: Vector2
@export var rotacion: int