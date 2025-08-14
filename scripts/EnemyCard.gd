extends Control

@onready var img = $sprite
@onready var name_label = $name_label
@onready var curr_hp_label = $curr_hp_label
@onready var max_hp_label = $max_hp_label

var dados: EnemyData

func set_data(data: EnemyData):
	img.texture = data.image
	name_label.text = data.name
	curr_hp_label.text = str(data.curr_hp)
	max_hp_label.text = str(data.max_hp)
