extends CharacterBody2D

# =====================================================
# BALL STATS
# =====================================================

@export var max_health : int = 20
@export var move_speed : float = 230.0
@export var explosion_damage : int = 50
@export var explosion_radius : float = 70.0

var current_health : int
var mutation_level : int = 1

# =====================================================
# REFERENCES
# =====================================================

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var explosion_area = $ExplosionArea
@onready var animation = $AnimationPlayer

# =====================================================
# READY
# =====================================================

func _ready():

	current_health = max_health

	var shape = explosion_area.get_node("CollisionShape2D").shape
	if shape is CircleShape2D:
		shape.radius = explosion_radius

# =====================================================
# MOVEMENT
# =====================================================

func _physics_process(delta):

	if player == null:
		return

	var direction = player.global_position - global_position

	velocity = direction.normalized() * move_speed

	look_at(player.global_position)

	move_and_slide()

# =====================================================
# COLLISION
# =====================================================

func _on_explosion_area_body_entered(body):

	if body.is_in_group("Player"):

		explode()

# =====================================================
# EXPLOSION
# =====================================================

func explode():

	if player == null:
		queue_free()
		return

	if global_position.distance_to(player.global_position) <= explosion_radius:

		player.take_damage(explosion_damage)

	queue_free()

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
			max_health = 30
			move_speed = 250
			explosion_damage = 75
			explosion_radius = 85

		3:
			max_health = 40
			move_speed = 270
			explosion_damage = 100
			explosion_radius = 100

		4:
			max_health = 55
			move_speed = 295
			explosion_damage = 130
			explosion_radius = 120

		5:
			max_health = 70
			move_speed = 320
			explosion_damage = 170
			explosion_radius = 150

	current_health = max_health

	var shape = explosion_area.get_node("CollisionShape2D").shape
	if shape is CircleShape2D:
		shape.radius = explosion_radius

# =====================================================
# DEATH
# =====================================================

func die():

	if player != null:

		player.heal(3)

	queue_free()
