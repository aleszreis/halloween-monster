extends Control

var player_card_scene = preload("res://scenes/PlayerCard.tscn")

# Array de PlayerData: 1 jogador + 7 AIs
var jogadores_data = []

@onready var player_area = $Screen/PlayerArea
@onready var enemy_area = $Screen/EnemyArea

func _ready():
	carregar_jogadores()
	criar_cartas()

func carregar_jogadores():
	# Carrega o jogador real
	var jogador_real = preload("res://data/player_template.tres")
	jogadores_data.append(jogador_real)

	# Cria 7 AIs a partir de um template
	var template_ai = preload("res://data/player_template.tres")
	for i in range(7):
		var ai = template_ai.duplicate(true)  # duplicar recursivamente
		ai.name = "AI %d" % (i + 1)
		jogadores_data.append(ai)

func criar_cartas():
	for data in jogadores_data:
		var card = player_card_scene.instantiate()
		player_area.add_child(card)
		card.set_data(data)
		player_area.add_child(card)
		prints('Loaded card')
