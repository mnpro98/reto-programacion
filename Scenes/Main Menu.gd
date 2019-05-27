#Script para configurar los botones
extends Control

func _ready():
	get_tree().paused = false
	
#Función para que cambie de escena cuando el botón sea presionado
func _on_Button1_pressed():
	get_tree().change_scene("res://Scenes/Main Game.tscn");

# Función para cerrar la aplicación
func _on_Button2_pressed():
	get_tree().quit()
