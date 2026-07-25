extends CharacterBody2D

# =====================================================
# SHOOTER STATS
# =====================================================

@export var max_health : int = 100
@export var move_speed : float = 120.0
@export var damage : int = 15

@export var attack_range : float = 400.0
@export var fire_rate : float = 1.0

@export var bullet_scene : PackedScene

var current_health : int
var mutation_level : int = 1

# =====================================================
# REFERENCES
# =====================================================

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var gun = $GunMarker
@onready var shoot_timer = $ShootTimer
@onready var animation = $AnimationPlayer

# =====================================================
# READY
# =====================================================

func _ready():

	current_health = max_health

	shoot_timer.wait_time = 1.0 / fire_rate
	shoot_timer.start()

# =====================================================
# PROCESS
# =====================================================

func _physics_process(delta):

	if player == null:
		return

	var distance = global_position.distance_to(player.global_position)

	if distance > attack_range:

		move_to_player()

	else:

		velocity = Vector2.ZERO

		look_at(player.global_position)

	move_and_slide()

# =====================================================
# MOVEMENT
# =====================================================

func move_to_player():

	var direction = player.global_position - global_position

	direction = direction.normalized()

	velocity = direction * move_speed

	look_at(player.global_position)

# =====================================================
# SHOOTING
# =====================================================

func _on_shoot_timer_timeout():

	if player == null:
		return

	if global_position.distance_to(player.global_position) > attack_range:
		return

	shoot()

func shoot():

	if bullet_scene == null:
		return

	var bullet = bullet_scene.instantiate()

	get_tree().current_scene.add_child(bullet)

	bullet.global_position = gun.global_position

	bullet.rotation = (player.global_position - gun.global_position).angle()

	bullet.damage = damage

# =====================================================
# DAMAGE
# =====================================================

func take_damage(amount : int):

	current_health -= amount

	if current_health <= 0:

		die()

# =====================================================
# MUTATION
# =====================================================

func mutate():

	mutation_level += 1

	match mutation_level:

		2:
			max_health = 140
			damage = 20
			move_speed = 135
			fire_rate = 1.3

		3:
			max_health = 190
			damage = 28
			move_speed = 150
			fire_rate = 1.6

		4:
			max_health = 260
			damage = 38
			move_speed = 165
			fire_rate = 2.0

		5:
			max_health = 350
			damage = 50
			move_speed = 180
			fire_rate = 2.5

	current_health = max_health

	shoot_timer.wait_time = 1.0 / fire_rate

# =====================================================
# DEATH
# =====================================================

func die():

	if player != null:

		player.heal(8)

	queue_free()
