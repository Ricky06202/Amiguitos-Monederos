extends AnimatedSprite2D

@onready var botonAnimation: AnimatedSprite2D = get_node(".")

func _ready():
	inicializar()

func _physics_process(delta):
	pass
	
func inicializar():
		botonAnimation.play("Boton_izq")
