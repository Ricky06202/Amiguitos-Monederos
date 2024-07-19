extends Node

var limite_de_vidas = 1

var vidas: int:
	set(v):
		vidas = clamp(vidas, 0, limite_de_vidas)

var punto_de_control_actual: Node2D

func reiniciar():
	vidas = 3

signal cambiar_transformacion(transformacion: Transformacion)

var enemigos := 0
var monedas := 0

signal pausar
signal ganar
signal perder

signal moneda_obtenida
signal enemigo_derrotado

var menu_principal: PackedScene = load("res://componentes/interfaz/menu principal/menu_principal.tscn")
var selector_niveles: PackedScene = load("res://componentes/interfaz/selector de niveles/selector_de_niveles.tscn")