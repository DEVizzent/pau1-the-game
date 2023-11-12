extends Node2D

func _ready():
	Events.collected.connect(_check_level_end)


func _check_level_end(_collectableName:String, _texture:Texture2D):
	var collectables = get_tree().get_nodes_in_group("mandatoryCollectables")
	if (collectables.size() == 1 && collectables[0].visible == false) || collectables.size() == 0:
		var scene:PackedScene = load("res://Scenes/Welcome.tscn")
		get_tree().change_scene_to_packed(scene)
