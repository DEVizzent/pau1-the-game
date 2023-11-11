extends Node
class_name HealthComponent

signal death
signal damaged(originPositionOfDamage:Vector2)

@export var health:int = 1:
	set(new_health):
		if new_health < health:
			inImmunityTime = true
		health = new_health
		if health < 1:
			emit_signal("death", lastDamageType)

@export var allowedDamageTypes:Array[Damage.Type] = []

const IMMUNITY_TIME_AFTER_DAMAGE:float = 0.5

var lastDamageType:Damage.Type
var inImmunityTime:bool = false:
	set(new_value):
		inImmunityTime = new_value
		if inImmunityTime && timer != null:
			timer.start()
var timer:Timer

func _ready()->void:
	if health > 1:
		timer = Timer.new()
		add_child(timer)
		timer.one_shot = true
		timer.autostart = false
		timer.wait_time
		timer.timeout.connect(finishImmunityTime)

func damage(type:Damage.Type, damageAmount:int, originPosition:Vector2) ->  bool:
	if allowedDamageTypes.has(type) && !inImmunityTime:
		lastDamageType=type
		health -= damageAmount
		emit_signal("damaged", originPosition)
		return true
	return false

func finishImmunityTime():
	inImmunityTime = false
