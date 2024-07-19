extends Area2D
class_name Hitbox

@export var dano := 1

func _ready():
	area_entered.connect(al_detectar_un_area)

func al_detectar_un_area(area: Area2D):
	if is_instance_of(area, Hurtbox):
		var hurtbox = area as Hurtbox
		hurtbox.recibirDano(dano)
		realizar_dano.emit()

signal realizar_dano
