extends Node

var limite_de_vidas = 1

var vidas: int:
	set(v):
		vidas = clamp(vidas, 0, limite_de_vidas)

var punto_de_control_actual: Node2D

func reiniciar():
	vidas = 3

signal cambiar_transformacion(transformacion: Transformacion)