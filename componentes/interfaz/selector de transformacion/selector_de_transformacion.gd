extends Control

func _ready():
	Estado.cambiar_transformacion.connect(al_cambiar_transformacion)

func pausar_despausar():
	get_tree().paused = !get_tree().paused
	visible = !visible

func _input(_event):
	if Input.is_action_just_released("Transformaciones"):
		pausar_despausar()

func al_cambiar_transformacion(_t):
	pausar_despausar()