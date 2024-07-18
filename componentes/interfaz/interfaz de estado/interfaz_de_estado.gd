extends Control

@onready var panel_monedas :Panel_Informativo= get_node("Panel Monedas")
@onready var panel_enemigos :Panel_Informativo= get_node("Panel Enemigos")

var monedas_obtenidas := 0:
	set(valor):
		monedas_obtenidas = valor
		panel_monedas.texto = str(monedas_obtenidas) + "/" + str(total_monedas)

var enemigos_derrotados := 0:
	set(valor):
		enemigos_derrotados = valor
		panel_enemigos.texto = str(enemigos_derrotados) + "/" + str(total_enemigos)

var total_monedas 
var total_enemigos

# Called when the node enters the scene tree for the first time.
func _ready():
	Estado.moneda_obtenida.connect(al_obtener_moneda)
	Estado.enemigo_derrotado.connect(al_derrotar_enemigo)
	total_monedas = get_tree().get_nodes_in_group("Monedas").size()
	total_enemigos = get_tree().get_nodes_in_group("Enemigos").size()

	panel_monedas.texto = str(monedas_obtenidas) + "/" + str(total_monedas)
	panel_enemigos.texto = str(enemigos_derrotados) + "/" + str(total_enemigos)

func _on_button_pressed():
	Estado.pausar.emit()

func al_obtener_moneda():
	monedas_obtenidas += 1
	
func al_derrotar_enemigo():
	enemigos_derrotados += 1
