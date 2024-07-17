extends Control

@export var nivel_a_cargar: PackedScene

func _on_salir_pressed():
	get_tree().quit()

func _on_jugar_pressed():
	get_tree().change_scene_to_packed(nivel_a_cargar)
