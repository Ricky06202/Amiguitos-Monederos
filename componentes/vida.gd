extends Node
class_name Vida

@export var puntos_de_vida := 1:
	set(nueva_cantidad):
		if nueva_cantidad > puntos_de_vida:
			recibir_cura.emit()
		elif nueva_cantidad < puntos_de_vida:
			recibir_dano.emit()
		
		if(nueva_cantidad <= 0):
			puntos_de_vida = 0
			sin_vida.emit()
		else:
			puntos_de_vida = nueva_cantidad

		

signal recibir_dano
signal recibir_cura
signal sin_vida