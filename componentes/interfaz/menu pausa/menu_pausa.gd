extends Control

func _ready():
	Estado.pausar.connect(pausar_despausar)

func pausar_despausar():
	get_tree().paused = !get_tree().paused
	visible = !visible

func _input(_event):
	if get_tree().paused and not visible: return
	if Input.is_action_just_released("Pausar"):
		pausar_despausar()

func _on_continuar_pressed():
	pausar_despausar()

func _on_salir_al_menu_principal_pressed():
	pausar_despausar()
	get_tree().change_scene_to_packed(Estado.menu_principal)

func _on_volver_al_punto_de_control_pressed():
	pausar_despausar()
	get_tree().change_scene_to_packed(Estado.selector_niveles)
