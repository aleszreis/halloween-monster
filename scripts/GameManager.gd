extends Node2D

var player_card_scene = preload("res://scenes/PlayerCard.tscn")
var enemy_card_scene = preload("res://scenes/EnemyCard.tscn")

var players: Array[PlayerData] = []
var monsters: Array[EnemyData] = []
var current_turn := 0
var battlefield_slots: Array = [null, null, null]  # null = slot vazio
var next_enemies: Array = []  # cartas esperando

signal game_loaded(players, monsters)

func _ready():
	setup_table()
	start_turn()
	
func carregar_jogadores():
	# Carrega o jogador real
	var jogador_real = preload("res://data/player_template.tres")
	players.append(jogador_real)

	# Cria 11 AIs a partir de um template
	var template_ai = preload("res://data/player_template.tres")
	for i in range(11):
		var ai = template_ai.duplicate(true)  # duplicar recursivamente
		ai.name = "AI %d" % (i + 1)
		players.append(ai)

func carregar_inimigos():
	# Carrega os inimigos
	var mermaid_template = preload("res://data/enemies_data/mermaid_template.tres")
	var minotaur_template = preload("res://data/enemies_data/minotaur_template.tres")
	var witch_template = preload("res://data/enemies_data/witch_template.tres")
	var merman_template = preload("res://data/enemies_data/merman_template.tres")
	var gnome_template = preload("res://data/enemies_data/gnome_template.tres")
	var demon_template = preload("res://data/enemies_data/demon_template.tres")
	monsters.append_array([mermaid_template, minotaur_template, witch_template, merman_template, gnome_template, demon_template])

func setup_table() -> void:
	carregar_jogadores()
	carregar_inimigos()
	emit_signal("game_loaded", players, monsters)

# Player's turn actions
func start_turn() -> void:
	var player = players[current_turn]
	emit_signal("turn_started", player)

func end_turn() -> void:
	var player = players[current_turn]
	emit_signal("turn_ended", player)
	current_turn = (current_turn + 1) % players.size()
	start_turn()

func player_attack_monster(player: PlayerData, monster: EnemyData, amount: int) -> void:
	monster.take_damage(amount)
	emit_signal("monster_damaged", monster, amount)
	print("%s causa %d de dano em %s (HP %d)" %
	[player.name, amount, monster.name, monster.hp])
	# Exemplo: fim do turno automático
	end_turn()

# Effects' turn actions
func try_move_card_to_battlefield():
	if not next_enemies:
		return
		
	# Procura primeiro slot vazio
	for i in range(battlefield_slots.size()):
		if battlefield_slots[i] == null:
			var card = next_enemies.pop_front()
			battlefield_slots[i] = card
			emit_signal("card_moved", card, i)
			return

func remove_card_from_battlefield(slot_index: int):
	battlefield_slots[slot_index] = null
	try_move_card_to_battlefield()  # preenche com próxima carta, se houver
