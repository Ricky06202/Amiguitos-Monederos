extends Node

var vidas: int:
	set(v):
		vidas = clamp(vidas, 0, 3)

var puntos: int

var siguiente_nivel: PackedScene

var punto_de_control_actual: Node2D