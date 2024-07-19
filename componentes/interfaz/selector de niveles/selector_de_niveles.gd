extends Control

@export var bosque: PackedScene
@export var nieve: PackedScene
@export var desierto: PackedScene
@export var cueva: PackedScene

func _on_volver_pressed():
	get_tree().change_scene_to_packed(Estado.menu_principal)

func _on_cueva_pressed():
	get_tree().change_scene_to_packed(cueva)


func _on_desierto_pressed():
	get_tree().change_scene_to_packed(desierto)


func _on_nieve_pressed():
	get_tree().change_scene_to_packed(nieve)

func _on_bosque_pressed():
	get_tree().change_scene_to_packed(bosque)
