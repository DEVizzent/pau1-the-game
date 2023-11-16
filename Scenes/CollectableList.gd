extends HBoxContainer

func _ready():
	Events.collected.connect(_on_collected)

func _on_collected(_collectableName:String, texture:Texture2D):
	var collectableIcon:TextureRect = TextureRect.new()
	collectableIcon.set_texture(texture)
	collectableIcon.custom_minimum_size = Vector2(50, 50)
	collectableIcon.expand_mode = TextureRect.EXPAND_FIT_HEIGHT
	collectableIcon.add_to_group("collectables-ui")
	add_child(collectableIcon)
