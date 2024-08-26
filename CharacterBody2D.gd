extends CharacterBody2D

const SPEED = 300.0 #velocidade do jogador 
const JUMP_VELOCITY = -450.0 #velocidade do pulo
var is_jumping = false
var apanhando
var morreu
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") #define a gravidade da situação


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta #nn faço ideia vou rasgar minha matricula

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		is_jumping = true
	elif is_on_floor():
		is_jumping = false
		
 
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right") #direção
	
	
	if direction !=0: 
		velocity.x = direction * SPEED
		$AnimatedSprite2D.scale.x = direction
		
		if !is_jumping:
			$AnimatedSprite2D.play("Run")
		else:
			$AnimatedSprite2D.play("Jump")
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		_animated_sprite.play("Idle")

	move_and_slide()
	
@onready var _animated_sprite = $AnimatedSprite2D

signal morri

func _levouDano():
	apanhando = true 
	velocity.x = -90000

	$AnimatedSprite2D.play("hit")
	await $AnimatedSprite2D.animation_finished
	apanhando = false
 #tomando dano obaaaaaaa
	morreu = false
	Global.vida -= Global.dano
	print ("vida", Global.vida)
#caso de você
	if Global.vida <=0:
		morreu = true 
		print("morreu?")
		emit_signal("morri")
