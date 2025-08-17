extends Node2D

var players: Array[PlayerData] = []
var enemies: Array[EnemyData] = []
var current_turn := 0
var battlefield_slots: Array = [null, null, null]  # null = slot vazio

signal game_loaded(players, battlefield, upnext)
signal enemy_died(index)
signal enemy_entered(enemy, slot_to_enter)

func _ready():
	setup_table()
	
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
	var dir := DirAccess.open("res://data/enemies_data")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir() and file_name.ends_with(".tres"):
				var enemy_template = load("res://data/enemies_data/%s" % file_name)
				enemies.append(enemy_template)
			file_name = dir.get_next()
		dir.list_dir_end()

func setup_table() -> void:
	carregar_jogadores()
	carregar_inimigos()
	while battlefield_slots.any(func(slot): return slot == null):
		try_move_card_to_battlefield()
	emit_signal("game_loaded", players, battlefield_slots, enemies)
	
func _on_field_slot_clicked(index):
	if battlefield_slots[index] != null:
		battlefield_slots[index] = null
		emit_signal("enemy_died", index)
		try_move_card_to_battlefield()

func try_move_card_to_battlefield():
	if not enemies:
		print("no enemies to pull")
		return
		
	for slot in range(battlefield_slots.size()):
		if battlefield_slots[slot] == null:
			var card = enemies.pop_front()
			battlefield_slots[slot] = card
			emit_signal("enemy_entered", slot)
			return
