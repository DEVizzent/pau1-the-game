extends CharacterBody2D


const SPEED = 600.0
const JUMP_VELOCITY = -1600.0
const ATTACK_JUMP_VELOCITY = -900.0
const DAMAGE_VELOCITY = 6000.0

@export var agachado:bool = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	$AttackFoot.attack_done.connect(attackJump)
	$HealthComponent.damaged.connect(gotDamage)


func _physics_process(delta):
	
	if (position.y > 2500):
		position.y = 0
		position.x = 0
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$Salto.play()
		
	$AnimationTree.set("parameters/conditions/agachado", Input.is_action_pressed("ui_down"))
	$AnimationTree.set("parameters/conditions/not_agachado", !Input.is_action_pressed("ui_down"))

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func attackJump() -> void:
	velocity.y = JUMP_VELOCITY if (Input.is_action_pressed("jump")) else ATTACK_JUMP_VELOCITY

func gotDamage(originPositionOfDamage) -> void:
	velocity = (global_position - originPositionOfDamage).normalized() * DAMAGE_VELOCITY
