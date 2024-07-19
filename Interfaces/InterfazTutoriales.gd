extends Control

var t_mover = false
var t_saltar = false
var t_dSaltar = false
var t_mSaltar = false
var t_bajo = false

func _physics_process(delta):
	inicializar()


func inicializar():
	#Mostrar tutorial de moverse
	if t_mover == false:
		$tutorial_mover.visible = false
	elif t_mover == true:
		$tutorial_mover.visible = true
	#Mostrar tutorial de saltar
	if t_saltar == false:
		$tutorial_saltar.visible = false
	elif t_saltar == true:
		$tutorial_saltar.visible = true
	#Mostrar tutorial de doble salto
	if t_dSaltar == false:
		$tutorial_dobleSalto.visible = false
	elif t_dSaltar == true:
		$tutorial_dobleSalto.visible = true
	#Mostrar tutorial de saltar muros
	if t_mSaltar == false:
		$tutorial_wallJump.visible = false
	elif t_mSaltar == true:
		$tutorial_wallJump.visible = true
	#Mostrar tutorial de pasar zonas bajas
	if t_bajo == false:
		$tutorial_lugarBajo.visible = false
	elif t_bajo == true:
		$tutorial_lugarBajo.visible = true

func _on_moverse_pressed():
	t_mover = true


func _on_saltar_pressed():
	t_saltar = true


func _on_doble_salto_pressed():
	t_dSaltar = true


func _on_salto_muro_pressed():
	t_mSaltar = true


func _on_pasar_bajo_pressed():
	t_bajo = true

#Para cerrar la ventana del tutorial
func _on_cerrar_pressed():
	t_mover = false
	t_saltar = false
	t_dSaltar = false
	t_mSaltar = false
	t_bajo = false


func _on_regresar_pressed():
	pass # Replace with function body.
