extends Sprite2D
class_name Collectable

@export var collectableName:String

@export var type:Type = Type.MANDATORY
enum Type {
	MANDATORY,
	OPTIONAL
}
func _ready():
	if type == Type.MANDATORY:
		add_to_group('mandatoryCollectables')
	else :
		add_to_group('optionalCollectables')

func _on_area_2d_body_entered(_playerBody):
	$SoundGotIt.play()
	visible = false
	position = Vector2.ZERO
	$SoundGotIt.finished.connect(queue_free)
	Events.emit_signal("collected", collectableName, texture)
