extends Sprite2D
class_name Collectable

@export var collectableName:String

func _ready():
	add_to_group('collectables')

func _on_area_2d_body_entered(_playerBody):
	$SoundGotIt.play()
	visible = false
	position = Vector2.ZERO
	$SoundGotIt.finished.connect(queue_free)
	Events.emit_signal("collected", collectableName, texture)
