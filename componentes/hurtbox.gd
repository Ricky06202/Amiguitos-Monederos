extends Area2D
class_name Hurtbox

@export var vida: Vida

func recibirDano(cantidad):
	vida.puntos_de_vida -= cantidad