extends Control

signal slot_clicked(index)

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("Slot clicado:", get_index())
		emit_signal("slot_clicked", get_index())
