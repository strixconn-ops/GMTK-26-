extends Node2D

# =====================================================
# SETTINGS
# =====================================================

@export var safezone_scene : PackedScene

# =====================================================
# VARIABLES
# =====================================================

var current_safe_zone : Area2D = null

# =====================================================
# REFERENCES
# =====================================================

@onready var spawn_points = $SpawnPoints
@onready var wave_manager = $"../WaveManager"

# =====================================================
# READY
# =====================================================

func _ready():

	randomize()

# =====================================================
# SPAWN SAFE ZONE
# =====================================================

func spawn_safe_zone():

	remove_safe_zone()

	if safezone_scene == null:
		return

	var zone = safezone_scene.instantiate()

	add_child(zone)

	current_safe_zone = zone

	current_safe_zone.global_position = get_random_position()

	current_safe_zone.body_entered.connect(_on_body_entered)
	current_safe_zone.body_exited.connect(_on_body_exited)

# =====================================================
# REMOVE SAFE ZONE
# =====================================================

func remove_safe_zone():

	if current_safe_zone != null:

		current_safe_zone.queue_free()

		current_safe_zone = null

# =====================================================
# RANDOM LOCATION
# =====================================================

func get_random_position() -> Vector2:

	var points = spawn_points.get_children()

	if points.is_empty():

		return Vector2.ZERO

	var marker = points[randi() % points.size()]

	return marker.global_position

# =====================================================
# PLAYER ENTER
# =====================================================

func _on_body_entered(body):

	if body.is_in_group("Player"):

		wave_manager.player_entered_safe_zone()

# =====================================================
# PLAYER EXIT
# =====================================================

func _on_body_exited(body):

	if body.is_in_group("Player"):

		wave_manager.player_exited_safe_zone()

# =====================================================
# GET CURRENT SAFE ZONE
# =====================================================

func get_safe_zone():

	return current_safe_zone
