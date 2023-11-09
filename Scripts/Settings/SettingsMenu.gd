extends CanvasLayer

func _input(event):
	if event.is_action_pressed("ui_menu"):
		visible = !visible
		get_tree().paused = visible
		$Panel/CenterContainer/VBoxContainer/GridContainer/ButtonRestart.grab_focus()
