extends CharacterBody2D


const SPEED = 300.0
@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(_delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * SPEED
	move_and_slide()
	
	if direction != Vector2.ZERO:
		# Choose animation based on dominant direction or vertical/horizontal priority
		if abs(direction.y) > abs(direction.x):
			if direction.y < 0:
				animated_sprite.play("walk back")       # Moving Up (W)
			else:
				animated_sprite.play("walk straight")   # Moving Down (S)
		else:
			animated_sprite.play("walk side")           # Moving Left/Right (A/D)
			animated_sprite.flip_h = direction.x < 0    # Flip sprite when moving left
	else:
		animated_sprite.stop()
