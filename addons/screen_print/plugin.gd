@tool
extends EditorPlugin

func _enter_tree():
	add_autoload_singleton("Screen", "res://addons/screen_print/screen.gd")

func _exit_tree():
	remove_autoload_singleton("Screen")