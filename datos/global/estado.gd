extends Node

var limite_de_vidas = 1

var vidas: int:
	set(v):
		vidas = clamp(vidas, 0, limite_de_vidas)

var punto_de_control_actual: Node2D

func reiniciar():
	vidas = 3

signal cambiar_transformacion(transformacion: Transformacion)
signal perdimos

var enemigos := 0
var monedas := 0

signal pausar

signal moneda_obtenida
signal enemigo_derrotado