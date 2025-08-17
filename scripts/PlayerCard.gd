extends Control

# SET PLAYER DATA
@export var img: TextureRect
@export var name_label: Label
@export var hp_label: Label

var dados: PlayerData

func set_data(data: PlayerData):
	dados = data
	img.texture = dados.image
	name_label.text = dados.name
	hp_label.text = str(dados.hp)

# CONFIG CARD ANIMATION
@export var hover_offset_px := -28.0  # quanto sobe (negativo pra subir)
@export var visual: Control
var tween: Tween

func _ready() -> void:
	# Garantias para sobrepor os vizinhos e não bloquear o mouse do pai
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_mouse_entered() -> void:
	if tween: tween.kill()
	visual.z_index = 500  # bem alto pra ficar por cima das outras cartas
	tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(visual, "position:y", hover_offset_px, 0.12)

func _on_mouse_exited() -> void:
	if tween: tween.kill()
	tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(visual, "position:y", 0.0, 0.12)
	tween.finished.connect(func ():
		visual.z_index = 0  # volta pro normal depois de abaixar
		)
