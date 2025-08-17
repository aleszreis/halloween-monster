extends Control

var player_card_scene = preload("res://scenes/PlayerCard.tscn")
var enemy_card_scene = preload("res://scenes/EnemyCard.tscn")

@export var player_area: GridContainer
@export var battlefield_area: GridContainer
@export var up_next_area: GridContainer

func _on_game_loaded(player_data, enemies_data):
	for p_data in player_data:
		var p_card = player_card_scene.instantiate()
		p_card.set_data(p_data)
		player_area.add_child(p_card)
	
	for i in range(battlefield_area.columns):
		var enemy_data = enemies_data.pop_at(0)
		var e_card = enemy_card_scene.instantiate()
		e_card.set_data(enemy_data)
		enter_battlefield(e_card)
		
	for i in range(up_next_area.columns):
		var enemy_data = enemies_data.pop_at(0)
		var e_card = enemy_card_scene.instantiate()
		e_card.set_data(enemy_data)
		up_next_area.add_child(e_card)

func _on_card_moved(card, slot_index: int):
	var visual = card.visual_node  # Node que representa a carta
	enter_battlefield(visual)

#func update_up_next():
	#while up_next_area.get_child_count() < 2 and enemies_data.size() > 0:
		#var en_card = enemy_card_scene.instantiate()
		#en_card.set_data(enemies_data.pop_at(0))
		#up_next_area.add_child(en_card)
	#

func enter_battlefield(card_to_enter):
	for child in battlefield_area.get_children():
		if child.get_child_count() == 0:
			#var enemy_to_enter = up_next_area.get_child(0, true)
			up_next_area.remove_child(card_to_enter)
			battlefield_area.find_child(child.name).add_child(card_to_enter)
