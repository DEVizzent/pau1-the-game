extends Node2D

func _ready():
	$StartButton.grab_focus()

func _on_start_button_pressed():
	var scene:PackedScene = load("res://Scenes/Levels/Level1.tscn")
	get_tree().change_scene_to_packed(scene)
