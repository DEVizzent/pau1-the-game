extends CharacterBody2D

@export var SPEED = 300.0
@export var MOVEMENT = 600

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var speedDirection = 1
var leftLimit := 0
var rightLimit := 0

func _ready():
	$AnimationPlayer.play("walking")
	$HealthComponent.death.connect(death)
	leftLimit = int(global_position.x) - MOVEMENT
	rightLimit = int(global_position.x) + MOVEMENT
	velocity.x = SPEED

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		if (position.y > 2500):
			queue_free()
	if (leftLimit > global_position.x || rightLimit < global_position.x) :
		speedDirection = -speedDirection
		scale.x = - scale.x
		$FlipSound.play()
	velocity.x = speedDirection * SPEED
	move_and_slide()

func death(damageType:Damage.Type):
	if damageType == Damage.Type.TOP:
		$AnimationPlayer.play("deathTop")
	$CollisionShape2D.disabled = true
	$FlipSound.stop()
	$DeathSound.play()
