extends Node

# =====================================================
# REFERENCES
# =====================================================

@onready var music = $BackgroundMusic

@onready var gunshot = $SFX/GunShot
@onready var explosion = $SFX/Explosion
@onready var player_hit = $SFX/PlayerHit
@onready var enemy_death = $SFX/EnemyDeath
@onready var upgrade = $SFX/Upgrade
@onready var wave = $SFX/Wave
@onready var heal = $SFX/Heal
@onready var button = $SFX/ButtonClick
@onready var victory = $SFX/Victory
@onready var game_over = $SFX/GameOver

# =====================================================
# READY
# =====================================================

func _ready():

	music.play()

# =====================================================
# MUSIC
# =====================================================

func play_music():

	if !music.playing:

		music.play()

func stop_music():

	music.stop()

# =====================================================
# SOUND EFFECTS
# =====================================================

func play_gun():

	gunshot.play()

func play_explosion():

	explosion.play()

func play_player_hit():

	player_hit.play()

func play_enemy_death():

	enemy_death.play()

func play_upgrade():

	upgrade.play()

func play_wave():

	wave.play()

func play_heal():

	heal.play()

func play_button():

	button.play()

func play_victory():

	victory.play()

func play_game_over():

	game_over.play()

# =====================================================
# VOLUME
# =====================================================

func set_music_volume(value : float):

	music.volume_db = value

func set_sfx_volume(value : float):

	gunshot.volume_db = value
	explosion.volume_db = value
	player_hit.volume_db = value
	enemy_death.volume_db = value
	upgrade.volume_db = value
	wave.volume_db = value
	heal.volume_db = value
	button.volume_db = value
	victory.volume_db = value
	game_over.volume_db = value

# =====================================================
# STOP ALL SFX
# =====================================================

func stop_all_sounds():

	gunshot.stop()
	explosion.stop()
	player_hit.stop()
	enemy_death.stop()
	upgrade.stop()
	wave.stop()
	heal.stop()
	button.stop()
	victory.stop()
	game_over.stop()
