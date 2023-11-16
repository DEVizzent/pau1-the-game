extends Node2D
class_name ElementRounder

var elements:Array[Node] = []
@export var radio:int = 400
@export var rotationSpeed:int = deg_to_rad(180)
var isRotationActive = false

func _init(_elements:Array[Node]):
	z_index = 100
	for element in _elements:
		if element.get("texture"):
			elements.append(element)
func start()->void:
	var angle = 0
	if (elements.size() == 0): 
		return
	angle = 360/elements.size()
	var newNode:Node2D
	var i:int = 0
	var tween:Tween = create_tween().chain()
	for element in elements:
		newNode = Sprite2D.new()
		newNode.texture = element.texture
		newNode.position = Vector2.ZERO
		newNode.scale = Vector2.ZERO
		add_child(newNode)
		var newPosition = Vector2(cos(deg_to_rad(angle*i)), sin(deg_to_rad(angle*i))) * radio
		tween.set_parallel()
		tween.tween_property(newNode, "scale", Vector2.ONE, .5).set_trans(Tween.TRANS_BOUNCE).set_delay(i*.5)
		tween.tween_property(newNode, "position", newPosition, 1.0).set_trans(Tween.TRANS_ELASTIC).set_delay((i+.5)*.5)
		i += 1
	tween.tween_callback(_startRotation)

func _startRotation()->void:
	isRotationActive = true
	var tween:Tween = create_tween().set_parallel()
	tween.tween_property(self, "scale", Vector2(3.0, 3.0), 2.0).set_delay(elements.size()*.8)
	tween.tween_property(self, "rotationSpeed", deg_to_rad(1080), 2.0).set_delay(elements.size()*.8)
	tween.tween_callback(_sendEndLevel).set_delay(elements.size()*.8+2)

func _sendEndLevel()->void:
	Events.emit_signal("levelEnd")

func _process(delta)->void:
	if !isRotationActive:
		return
	rotation += delta * rotationSpeed
