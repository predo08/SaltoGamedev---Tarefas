extends CharacterBody2D

enum Estado { IDLE, WALK, JUMP }
var estado_atual = Estado.IDLE

@onready var sprite = $AnimatedSprite2D
var speed = 200
var jump_velocity = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		
	match estado_atual:
		
		Estado.IDLE:
			sprite.play("Idle")
			velocity.x = 0
			
			if Input.is_action_pressed('ui_right') or Input.is_action_pressed('ui_left'):
				estado_atual = Estado.WALK
			elif Input.is_action_pressed('ui_up') and is_on_floor():
				velocity.y = jump_velocity
				estado_atual = Estado.JUMP
				
		Estado.WALK:
			sprite.play("Walk")
			
			if Input.is_action_pressed('ui_right'):
				velocity.x = speed
			elif Input.is_action_pressed('ui_left'):
				velocity.x = -speed
			else:
				estado_atual = Estado.IDLE
				
			if Input.is_action_pressed('ui_up') and is_on_floor():
				velocity.y = jump_velocity
				estado_atual = Estado.JUMP
				
		Estado.JUMP:
			sprite.play("Jump")
			
			if Input.is_action_pressed('ui_right'):
				velocity.x = speed
			elif Input.is_action_pressed('ui_left'):
				velocity.x = -speed
			else:
				velocity.x = 0
			if is_on_floor():
				if Input.is_action_pressed('ui_right') or Input.is_action_pressed('ui_left'):
					estado_atual = Estado.WALK
				else:
					estado_atual = Estado.IDLE
					
	move_and_slide()
