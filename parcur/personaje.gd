extends CharacterBody2D

const SPEED := 300
const JUMP_VELOCITY := -500
const GRAVITY := 1000.0

@onready var anim := $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Gravedad
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Movimiento horizontal
	var direction := Input.get_action_strength("right") - Input.get_action_strength("left")
	velocity.x = direction * SPEED

	# Salto
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY

	# ---- ANIMACIÓN ----
	if direction != 0:
		# reproducir caminar si no está ya reproduciendo
		if anim.animation != "walk" or not anim.is_playing():
			anim.play("walk")

		# girar sprite
		anim.flip_h = direction < 0
	else:
		# quedarse quieto en el primer frame
		anim.stop()
		anim.frame = 1

	# Aplicar movimiento
	move_and_slide()
