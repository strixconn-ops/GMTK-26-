extends Node

# ==========================================================
# SIGNALS
# ==========================================================

signal round_started(round)
signal countdown_updated(time_left)
signal round_finished(round)
signal game_completed()

# ==========================================================
# SETTINGS
# ==========================================================

@export var max_rounds : int = 5
@export var round_duration : int = 60

# ==========================================================
# ROUND DATA
# ==========================================================

var current_round : int = 1
var time_left : int = 60
var game_running : bool = false

# ==========================================================
# REFERENCES
# ==========================================================

@onready var timer : Timer = $RoundTimer

# ==========================================================
# READY
# ==========================================================

func _ready():

	timer.wait_time = 1.0
	timer.one_shot = false
	timer.timeout.connect(_on_timer_timeout)

# ==========================================================
# START GAME
# ==========================================================

func start_game():

	current_round = 1

	start_round()

# ==========================================================
# START ROUND
# ==========================================================

func start_round():

	game_running = true

	time_left = round_duration

	emit_signal("round_started", current_round)

	timer.start()

# ==========================================================
# TIMER
# ==========================================================

func _on_timer_timeout():

	if !game_running:
		return

	time_left -= 1

	emit_signal("countdown_updated", time_left)

	if time_left <= 0:

		finish_round()

# ==========================================================
# FINISH ROUND
# ==========================================================

func finish_round():

	timer.stop()

	game_running = false

	emit_signal("round_finished", current_round)

# ==========================================================
# NEXT ROUND
# ==========================================================

func next_round():

	current_round += 1

	if current_round > max_rounds:

		emit_signal("game_completed")

		return

	start_round()

# ==========================================================
# PAUSE
# ==========================================================

func pause_round():

	timer.stop()

# ==========================================================
# RESUME
# ==========================================================

func resume_round():

	timer.start()

# ==========================================================
# STOP GAME
# ==========================================================

func stop_game():

	timer.stop()

	game_running = false

# ==========================================================
# GETTERS
# ==========================================================

func get_current_round():

	return current_round


func get_time_left():

	return time_left


func is_running():

	return game_running
