extends Node2D

func _ready():
	Events.collected.connect(_check_level_completed)
	Events.levelEnd.connect(_level_end)


func _check_level_completed(_collectableName:String, _texture:Texture2D):
	var mandatoryCollectables = get_tree().get_nodes_in_group("mandatoryCollectables")
	if (mandatoryCollectables.size() == 1 && mandatoryCollectables[0].visible == false) || mandatoryCollectables.size() == 0:
		Events.emit_signal("levelCompleted")
		var collectedCollectables = get_tree().get_nodes_in_group("collectables-ui")
		if collectedCollectables.size() == 0:
			return
		var rounder = ElementRounder.new(collectedCollectables)
		$PlayerPau.add_child(rounder)
		rounder.start()
		

func _level_end():
	var scene:PackedScene = load("res://Scenes/Welcome.tscn")
	get_tree().change_scene_to_packed(scene)
