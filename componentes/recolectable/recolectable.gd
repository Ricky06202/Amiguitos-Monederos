@tool
extends Area2D

@onready var animacion: AnimatedSprite2D = get_node("AnimatedSprite2D")
@onready var fondo: Sprite2D = get_node("Fondo")

@export var recolectable: Recolectable:
	set(r):
		recolectable = r
		inicializar()

	
# Called when the node enters the scene tree for the first time.
func _ready():
	inicializar()

func inicializar():
	if animacion:
		animacion.sprite_frames = recolectable.animacion
		animacion.scale = Vector2(recolectable.escala, recolectable.escala)
		animacion.position.y = recolectable.posicionY
		if recolectable.transformacion:
			animacion.flip_h = recolectable.transformacion.hay_que_volterarla
			# if recolectable.animacion.has_animation("Quieto"):
			# 	animacion.animation = "Quieto"
			fondo.visible = true
		else:
			fondo.visible = false
		animacion.play()


func _on_body_entered(_body:Node2D):
	obtenerMoneda()

func obtenerMoneda():
	#todo   particulas y sonido
	Estado.moneda_obtenida.emit()
	queue_free()
