extends Control

@export var img: TextureRect
@export var name_label: Label
@export var hp_label: Label

var dados: PlayerData

func set_data(data: PlayerData):
	dados = data
	img.texture = dados.image
	name_label.text = dados.name
	hp_label.text = str(dados.hp)
