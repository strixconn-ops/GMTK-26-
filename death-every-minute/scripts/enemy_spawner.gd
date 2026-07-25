extends Node

# =====================================================
# ENEMY SCENES
# =====================================================

@export var shooter_scene : PackedScene
@export var ball_scene : PackedScene

# =====================================================
# SPAWN SETTINGS
# =====================================================

@export var spawn_interval : float = 3.0

var shooter_count : int = 5
var ball_count : int = 3

var shooter_spawned : int = 0
var ball_spawned : int = 0

# =====================================================
# REFERENCES
# =====================================================

@onready var spawn_timer : Timer = $SpawnTimer
@onready var spawn_points = $"../World/SpawnPoints"

# =====================================================
# READY
# =====================================================

func _ready():

	randomize()

	spawn_timer.timeout.connect(_on_spawn_timer_timeout)

# =====================================================
# START ROUND
# =====================================================

func start_round(round : int):

	match round:

		1:
			shooter_count = 5
			ball_count = 3

		2:
			shooter_count = 8
			ball_count = 5

		3:
			shooter_count = 12
			ball_count = 8

		4:
			shooter_count = 16
			ball_count = 12

		5:
			shooter_count = 20
			ball_count = 16

	shooter_spawned = 0
	ball_spawned = 0

	spawn_timer.start()

# =====================================================
# STOP SPAWNING
# =====================================================

func stop_spawning():

	spawn_timer.stop()

# =====================================================
# TIMER
# =====================================================

func _on_spawn_timer_timeout():

	if shooter_spawned < shooter_count:

		spawn_shooter()

		shooter_spawned += 1

	if ball_spawned < ball_count:

		spawn_ball()

		ball_spawned += 1

	if shooter_spawned >= shooter_count and ball_spawned >= ball_count:

		spawn_timer.stop()

# =====================================================
# SPAWN SHOOTER
# =====================================================

func spawn_shooter():

	if shooter_scene == null:
		return

	var enemy = shooter_scene.instantiate()

	get_tree().current_scene.add_child(enemy)

	enemy.global_position = get_random_spawn_position()

# =====================================================
# SPAWN BALL
# =====================================================

func spawn_ball():

	if ball_scene == null:
		return

	var enemy = ball_scene.instantiate()

	get_tree().current_scene.add_child(enemy)

	enemy.global_position = get_random_spawn_position()

# =====================================================
# RANDOM SPAWN
# =====================================================

func get_random_spawn_position() -> Vector2:

	var points = spawn_points.get_children()

	if points.is_empty():

		return Vector2.ZERO

	var point = points[randi() % points.size()]

	return point.global_position
