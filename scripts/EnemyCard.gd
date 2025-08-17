extends Control

signal request_remove(card)

@export var img: TextureRect
@export var name_label: Label
@export var hp_label: Label

var dados: EnemyData

func set_data(data: EnemyData):
	dados = data
	img.texture = dados.image
	name_label.text = dados.name
	hp_label.text = str(dados.hp)

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		emit_signal("request_remove", self)
