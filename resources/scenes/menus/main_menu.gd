extends Control

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://resources/scenes/menus/multiplayer.tscn")


func _on_options_button_pressed():
	get_tree().change_scene_to_file("res://resources/scenes/menus/options_menu.tscn")


func _on_quit_button_pressed():
	get_tree().quit()


func _on_practice_button_pressed():
	get_tree().change_scene_to_file("res://resources/scenes/levels/debug.tscn")
