extends Control

func _ready():
	Estado.perder.connect(mostrar)

func mostrar():
	get_tree().paused = !get_tree().paused
	visible = true

func _on_reintentar_pressed():
	get_tree().paused = !get_tree().paused
	get_tree().reload_current_scene()

func _on_elegir_nivel_pressed():
	get_tree().paused = !get_tree().paused
	get_tree().change_scene_to_packed(Estado.selector_niveles)

func _on_salir_al_menu_principal_pressed():
	get_tree().paused = !get_tree().paused
	get_tree().change_scene_to_packed(Estado.menu_principal)