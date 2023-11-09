extends RayCast2D

@export var damageType:Damage.Type = Damage.Type.TOP
@export var damageAmount:int = 1

signal attack_done

func _process(_delta):
	if is_colliding():
		var collider = get_collider()
		if collider.has_node("HealthComponent"):
			if collider.get_node("HealthComponent").damage(damageType, 1, global_position):
				emit_signal("attack_done")
			
		
