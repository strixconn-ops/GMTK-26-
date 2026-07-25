extends CanvasLayer

# =====================================================
# SIGNALS
# =====================================================

signal upgrade_selected

# =====================================================
# REFERENCES
# =====================================================

@onready var menu = $UpgradeMenu
@onready var health_button = $UpgradeMenu/HealthButton
@onready var damage_button = $UpgradeMenu/DamageButton
@onready var speed_button = $UpgradeMenu/SpeedButton

var player = null

# =====================================================
# READY
# =====================================================

func _ready():

	player = get_tree().get_first_node_in_group("Player")

	menu.visible = false

	health_button.pressed.connect(_on_health_pressed)
	damage_button.pressed.connect(_on_damage_pressed)
	speed_button.pressed.connect(_on_speed_pressed)

# =====================================================
# SHOW MENU
# =====================================================

func show_upgrade_menu():

	menu.visible = true

	get_tree().paused = true

# =====================================================
# HIDE MENU
# =====================================================

func hide_upgrade_menu():

	menu.visible = false

	get_tree().paused = false

	emit_signal("upgrade_selected")

# =====================================================
# HEALTH
# =====================================================

func _on_health_pressed():

	if player == null:
		return

	match get_current_round():

		2:
			player.increase_health(30)

		3:
			player.increase_health(40)

		4:
			player.increase_health(50)

		5:
			player.increase_health(60)

	hide_upgrade_menu()

# =====================================================
# DAMAGE
# =====================================================

func _on_damage_pressed():

	if player == null:
		return

	match get_current_round():

		2:
			player.increase_damage(5)

		3:
			player.increase_damage(8)

		4:
			player.increase_damage(10)

		5:
			player.increase_damage(15)

	hide_upgrade_menu()

# =====================================================
# SPEED
# =====================================================

func _on_speed_pressed():

	if player == null:
		return

	match get_current_round():

		2:
			player.increase_speed(20)

		3:
			player.increase_speed(25)

		4:
			player.increase_speed(30)

		5:
			player.increase_speed(35)

	hide_upgrade_menu()

# =====================================================
# GET CURRENT ROUND
# =====================================================

func get_current_round():

	var round_manager = get_tree().get_first_node_in_group("RoundManager")

	if round_manager == null:
		return 1

	return round_manager.current_round
