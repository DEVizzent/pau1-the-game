extends HBoxContainer

@export var heartTexture:Texture2D

func _ready()->void:
	Events.connect("updateHearts", _updateHearts)

func _updateHearts(hearts:int)->void:
	var childCount:int = get_child_count()
	while (childCount > hearts):
		var child = get_child(0)
		if (child == null):
			return
		remove_child(child)
		childCount -= 1
	while (childCount < hearts):
		var heart := TextureRect.new()
		heart.set_texture(heartTexture)
		heart.custom_minimum_size = Vector2(80,80) 
		heart.expand_mode = TextureRect.EXPAND_FIT_HEIGHT
		self.add_child(heart)
		childCount += 1
