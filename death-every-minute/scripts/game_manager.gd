extends Node

# =====================================================
# GAME SETTINGS
# =====================================================

@export var max_rounds : int = 5
@export var round_time : int = 60

# =====================================================
# GAME STATE
# =====================================================

var current_round : int = 1
var time_left : int = 60
var game_over : bool = false

# =====================================================
# REFERENCES
# =====================================================

@onready var round_timer = $RoundTimer
@onready var enemy_spawner = $"../EnemySpawner"
@onready var wave_manager = $"../WaveManager"
@onready var safezone_manager = $"../SafeZoneManager"
@onready var upgrade_manager = $"../UpgradeManager"
@onready var ui_manager = $"../UIManager"

# =====================================================
# READY
# =====================================================

func _ready():

	start_round()

# =====================================================
# START ROUND
# =====================================================

func start_round():

	print("Round ", current_round, " Started")

	time_left = round_time

	ui_manager.update_round(current_round)
	ui_manager.update_timer(time_left)

	enemy_spawner.start_round(current_round)

	safezone_manager.spawn_safe_zone()

	round_timer.start()

# =====================================================
# TIMER
# =====================================================

func _on_round_timer_timeout():

	if game_over:
		return

	time_left -= 1

	ui_manager.update_timer(time_left)

	if time_left <= 0:

		end_round()

	else:

		round_timer.start()

# =====================================================
# END ROUND
# =====================================================

func end_round():

	print("Round Finished")

	round_timer.stop()

	wave_manager.start_wave()

	await wave_manager.wave_finished

	mutate_enemies()

	show_upgrade()

# =====================================================
# MUTATION
# =====================================================

func mutate_enemies():

	var enemies = get_tree().get_nodes_in_group("Enemy")

	for enemy in enemies:

		enemy.mutate()

# =====================================================
# UPGRADE
# =====================================================

func show_upgrade():

	upgrade_manager.show_upgrade_menu()

	await upgrade_manager.upgrade_selected

	next_round()

# =====================================================
# NEXT ROUND
# =====================================================

func next_round():

	current_round += 1

	if current_round > max_rounds:

		victory()

		return

	start_round()

# =====================================================
# PLAYER DIED
# =====================================================

func player_died():

	if game_over:
		return

	game_over = true

	round_timer.stop()

	ui_manager.show_game_over()

# =====================================================
# VICTORY
# =====================================================

func victory():

	game_over = true

	round_timer.stop()

	ui_manager.show_victory()
