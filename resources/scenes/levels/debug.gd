extends Node2D

var players = {}

func _input(event):
	if event.is_action_pressed("escape"):
		get_tree().change_scene_to_file("res://resources/scenes/menus/main_menu.tscn")
