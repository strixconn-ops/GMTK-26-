extends Area2D

# =====================================================
# HEALTH ORB
# =====================================================

@export var heal_amount : int = 10
@export var life_time : float = 10.0
@export var rotation_speed : float = 180.0
@export var bob_speed : float = 3.0
@export var bob_height : float = 5.0

var start_position : Vector2
var time : float = 0.0

# =====================================================
# READY
# =====================================================

func _ready():

	start_position = global_position

	body_entered.connect(_on_body_entered)

	var timer := Timer.new()
	timer.wait_time = life_time
	timer.one_shot = true
	timer.timeout.connect(queue_free)

	add_child(timer)
	timer.start()

# =====================================================
# PROCESS
# =====================================================

func _process(delta):

	time += delta

	rotation += deg_to_rad(rotation_speed * delta)

	global_position.y = start_position.y + sin(time * bob_speed) * bob_height

# =====================================================
# PLAYER PICKUP
# =====================================================

func _on_body_entered(body):

	if body.is_in_group("Player"):

		body.heal(heal_amount)

		queue_free()
