extends CharacterBody2D


const SPEED = 600.0
const JUMP_VELOCITY = -1600.0
const ATTACK_JUMP_VELOCITY = -900.0
const DAMAGE_VELOCITY = 300.0
const LOST_CONTROL_BY_DAMAGE_TIME = 0.2

@export var agachado:bool = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var timerControl:Timer = $TimerControl
var lostControlByDamage:bool = false:
	set(new_value):
		lostControlByDamage = new_value
		if lostControlByDamage:
			timerControl.start(LOST_CONTROL_BY_DAMAGE_TIME)
		

func _ready():
	$AttackFoot.attack_done.connect(attackJump)
	$HealthComponent.damaged.connect(gotDamage)
	Events.emit_signal("updateHearts", $HealthComponent.health)
	timerControl.timeout.connect(recoverControlByDamage)


func _physics_process(delta):
	
	if (position.y > 2500):
		position.y = 0
		position.x = 0
		$HealthComponent.damage(Damage.Type.ENEMY, 1, position)
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	playerMovement()

	move_and_slide()

func playerMovement()->void:
	if lostControlByDamage:
		return
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$Salto.play()
		
	$AnimationTree.set("parameters/conditions/agachado", Input.is_action_pressed("ui_down"))
	$AnimationTree.set("parameters/conditions/not_agachado", !Input.is_action_pressed("ui_down"))

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

func attackJump() -> void:
	velocity.y = JUMP_VELOCITY if (Input.is_action_pressed("jump")) else ATTACK_JUMP_VELOCITY

func gotDamage(originPositionOfDamage) -> void:
	velocity = (global_position - originPositionOfDamage).normalized() * DAMAGE_VELOCITY
	velocity.y *= 10
	lostControlByDamage = true
	Events.emit_signal("updateHearts", $HealthComponent.health)

func recoverControlByDamage()->void:
	lostControlByDamage = false
