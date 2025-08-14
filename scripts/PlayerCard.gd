extends Control

@onready var img = $sprite
@onready var name_label = $nome
@onready var hp_label = $hp

var dados: PlayerData

func set_data(data: PlayerData):
	dados = data
	img.texture = dados.image
	name_label.text = dados.name
	hp_label.text = str(dados.hp)
