extends Node
class_name HealthComponent

signal death
signal damaged(originPositionOfDamage:Vector2)

@export var healt:int:
	set(_value):
		if healt < 1:
			emit_signal("death", lastDamageType)
			
@export var allowedDamageTypes:Array[Damage.Type] = []

var lastDamageType:Damage.Type

func damage(type:Damage.Type, damageAmount:int, originPosition:Vector2) ->  bool:
	if allowedDamageTypes.has(type):
		lastDamageType=type
		healt -= damageAmount
		emit_signal("damaged", originPosition)
		return true
	return false
