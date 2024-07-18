@tool
extends AnimatedSprite2D

@onready var moverseAnimation: AnimatedSprite2D = get_node(".")
var timeChangeFacing = 2.0

@export var transformacion_actual: Transformacion:
	set(t):
		transformacion_actual = t
		inicializar()

func _ready():
	inicializar()

func _physics_process(delta):
	timeChange(delta)

func inicializar():
	if moverseAnimation:
		moverseAnimation.sprite_frames = transformacion_actual.animacion
		moverseAnimation.play("mover")
		moverseAnimation.flip_h = transformacion_actual.hay_que_volterarla
		moverseAnimation.position = Vector2(119,47)
		moverseAnimation.scale = Vector2(transformacion_actual.escala, transformacion_actual.escala)
		
func timeChange(delta):
	timeChangeFacing -= delta
	if timeChangeFacing <= 0:
		scale.x *= - 1
		timeChangeFacing = 2.0
		
