extends Control

var player_card_scene = preload("res://scenes/PlayerCard.tscn")

# Array de PlayerData: 1 jogador + 7 AIs
var jogadores_data = []

@export var player_area: HFlowContainer
@export var battlefield_area: HBoxContainer
@export var up_next_area: HBoxContainer

func _ready():
	carregar_jogadores()
	criar_cartas()

func carregar_jogadores():
	# Carrega o jogador real
	var jogador_real = preload("res://data/player_template.tres")
	jogadores_data.append(jogador_real)

	# Cria 11 AIs a partir de um template
	var template_ai = preload("res://data/player_template.tres")
	for i in range(14):
		var ai = template_ai.duplicate(true)  # duplicar recursivamente
		ai.name = "AI %d" % (i + 1)
		jogadores_data.append(ai)

func criar_cartas():
	for data in jogadores_data:
		var card = player_card_scene.instantiate()
		player_area.add_child(card)
		card.set_data(data)
		player_area.add_child(card)
