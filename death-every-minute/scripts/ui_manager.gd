extends CanvasLayer

# ==========================================================
# REFERENCES
# ==========================================================

@onready var hud = $HUD

@onready var health_bar = $HUD/HealthBar
@onready var health_text = $HUD/HealthText
@onready var timer_text = $HUD/TimerText
@onready var round_text = $HUD/RoundText
@onready var score_text = $HUD/ScoreText

@onready var upgrade_menu = $UpgradeMenu
@onready var pause_menu = $PauseMenu
@onready var game_over_menu = $GameOverMenu
@onready var victory_menu = $VictoryMenu

# ==========================================================
# VARIABLES
# ==========================================================

var score : int = 0

# ==========================================================
# READY
# ==========================================================

func _ready():

	upgrade_menu.hide()
	pause_menu.hide()
	game_over_menu.hide()
	victory_menu.hide()

# ==========================================================
# HEALTH
# ==========================================================

func update_health(current_health : int, max_health : int):

	health_bar.max_value = max_health
	health_bar.value = current_health

	health_text.text = str(current_health) + " / " + str(max_health)

# ==========================================================
# TIMER
# ==========================================================

func update_timer(time_left : int):

	timer_text.text = str(time_left)

# ==========================================================
# ROUND
# ==========================================================

func update_round(round : int):

	round_text.text = "ROUND " + str(round)

# ==========================================================
# SCORE
# ==========================================================

func add_score(points : int):

	score += points

	score_text.text = str(score)

func reset_score():

	score = 0

	score_text.text = "0"

# ==========================================================
# UPGRADE MENU
# ==========================================================

func show_upgrade():

	upgrade_menu.show()

func hide_upgrade():

	upgrade_menu.hide()

# ==========================================================
# PAUSE MENU
# ==========================================================

func show_pause():

	pause_menu.show()

	get_tree().paused = true

func hide_pause():

	pause_menu.hide()

	get_tree().paused = false

# ==========================================================
# GAME OVER
# ==========================================================

func show_game_over():

	game_over_menu.show()

	get_tree().paused = true

# ==========================================================
# VICTORY
# ==========================================================

func show_victory():

	victory_menu.show()

	get_tree().paused = true

# ==========================================================
# RESET UI
# ==========================================================

func reset():

	reset_score()

	hide_upgrade()

	pause_menu.hide()

	game_over_menu.hide()

	victory_menu.hide()
