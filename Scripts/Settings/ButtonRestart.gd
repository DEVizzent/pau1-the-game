extends Button

func _pressed():
	get_tree().reload_current_scene()
	get_tree().paused = false
	
