extends Node2D

# =====================================================
# SIGNALS
# =====================================================

signal wave_started
signal wave_finished

# =====================================================
# SETTINGS
# =====================================================

@export var wave_speed : float = 800.0
@export var damage_per_second : int = 40
@export var wave_duration : float = 8.0

# =====================================================
# VARIABLES
# =====================================================

var wave_active : bool = false
var player_in_safe_zone : bool = false

# =====================================================
# REFERENCES
# =====================================================

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var deadly_wave = $DeadlyWave

# =====================================================
# READY
# =====================================================

func _ready():

	deadly_wave.visible = false
	deadly_wave.monitoring = false

# =====================================================
# START WAVE
# =====================================================

func start_wave():

	wave_active = true

	deadly_wave.visible = true
	deadly_wave.monitoring = true

	emit_signal("wave_started")

	await move_wave()

	finish_wave()

# =====================================================
# MOVE WAVE
# =====================================================

func move_wave():

	var elapsed := 0.0

	while elapsed < wave_duration:

		var delta = get_process_delta_time()

		elapsed += delta

		deadly_wave.position.x += wave_speed * delta

		if player != null:

			if !player_in_safe_zone:

				player.take_damage(damage_per_second * delta)

		await get_tree().process_frame

# =====================================================
# FINISH WAVE
# =====================================================

func finish_wave():

	wave_active = false

	deadly_wave.visible = false
	deadly_wave.monitoring = false

	emit_signal("wave_finished")

# =====================================================
# SAFE ZONE
# =====================================================

func player_entered_safe_zone():

	player_in_safe_zone = true

func player_exited_safe_zone():

	player_in_safe_zone = false

# =====================================================
# GETTERS
# =====================================================

func is_wave_active():

	return wave_active
