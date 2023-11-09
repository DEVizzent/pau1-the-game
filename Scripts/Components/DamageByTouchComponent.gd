extends Area2D
class_name DamageByTouchComponent


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if has_overlapping_bodies():
		for body in get_overlapping_bodies():
			if body.has_node("HealthComponent"):
				body.get_node("HealthComponent").damage(Damage.Type.ENEMY, 1, global_position)
