extends Control

@onready var t_mover : Control = get_node("tutorial_mover")
@onready var t_saltar : Control = get_node("tutorial_saltar")
@onready var t_dSaltar : Control = get_node("tutorial_dobleSalto")
@onready var t_mSaltar : Control = get_node("tutorial_wallJump")
@onready var t_bajo : Control = get_node("tutorial_lugarBajo")

func _on_moverse_pressed():
	cerrarTutoriales()
	t_mover.visible = true

func _on_saltar_pressed():
	cerrarTutoriales()
	t_saltar.visible = true

func _on_doble_salto_pressed():
	cerrarTutoriales()
	t_dSaltar.visible = true

func _on_salto_muro_pressed():
	cerrarTutoriales()
	t_mSaltar.visible = true

func _on_pasar_bajo_pressed():
	cerrarTutoriales()
	t_bajo.visible = true

func cerrarTutoriales():
	t_mover.visible = false
	t_saltar.visible = false
	t_dSaltar.visible = false
	t_mSaltar.visible = false
	t_bajo.visible = false

#Para cerrar la ventana del tutorial
func _on_cerrar_pressed():
	visible = false
