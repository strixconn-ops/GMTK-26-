extends WorldEnvironment

# --- Node References ---
# Using the exact names from your scene tree
@onready var enemy_spawner = $Enemey
@onready var game_manager = $GameManager
@onready var projectiles = $Projectiles
@onready var pickups = $pickups
@onready var spawn_timer = $"spawn timer"
@onready var round_timer = $"round timer"
@onready var player = $Player
@onready var map = $Map

# --- Game Variables ---
var current_wave: int = 1

func _ready() -> void:
	# Connect the timers via code so we don't have to rely on editor signals
	round_timer.timeout.connect(_on_round_timer_timeout)
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	
	# Initialize the first wave
	start_wave()

func start_wave() -> void:
	print("Starting Wave: ", current_wave)
	
	# Start the 60-second wave timer
	round_timer.wait_time = 60.0
	round_timer.start()
	
	# Start spawning enemies (e.g., every 2 seconds to start)
	# We will adjust this rate based on the wave number later
	spawn_timer.wait_time = 2.0 
	spawn_timer.start()

func _on_spawn_timer_timeout() -> void:
	# We will fill this in when we write the 'Enemey' script
	# Example: enemy_spawner.spawn_enemy()
	pass

func _on_round_timer_timeout() -> void:
	print("Wave ", current_wave, " Complete!")
	spawn_timer.stop()
	
	# Pause the game loop while the player chooses an upgrade
	get_tree().paused = true
	
	# Later, we will load your upgrade_manager.tscn here to handle stats
