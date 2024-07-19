extends Control

func _ready():
	Estado.ganar.connect(mostrar)

func mostrar():
	get_tree().paused = !get_tree().paused
	visible = true


func _on_elegir_nivel_pressed():
	get_tree().paused = !get_tree().paused
	get_tree().change_scene_to_packed(Estado.selector_niveles)

func _on_salir_al_menu_principal_pressed():
	get_tree().paused = !get_tree().paused
	get_tree().change_scene_to_packed(Estado.menu_principal)