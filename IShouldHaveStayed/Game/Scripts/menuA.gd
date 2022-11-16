extends Control

@export var quit_to_scene : String = "res://Game/Scenes/main.tscn";

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#reloads the current scene
func _on_button_restart_pressed():
	get_tree().reload_current_scene();

func _on_button_view_score_board_pressed():
	#read off of where ever its stored 
	pass # Replace with function body.

func _on_button_quit_pressed():
	get_tree().change_scene_to_file(quit_to_scene);
