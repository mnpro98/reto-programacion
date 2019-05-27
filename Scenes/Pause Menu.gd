# Script para el pause menu
extends Control

# Funciones para cuando presionas 'esc'
func _input(event):
	if event.is_action_pressed("ui_pause"):
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		visible = new_pause_state

# Funciones para cuando presionas el botón 'continue'
func _on_Return_pressed():
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	visible = new_pause_state

# Funciones para cuando presionas el botón 'main menu'
func _on_Main_Menu_pressed():
	get_tree().change_scene("res://Scenes/Main Menu.tscn")
