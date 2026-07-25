extends Node

# =====================================================
# SAVE FILE
# =====================================================

const SAVE_PATH = "user://save_game.save"

# =====================================================
# SAVE DATA
# =====================================================

var save_data = {

	"best_score":0,
	"highest_round":1,
	"total_kills":0,
	"play_time":0.0,

	"music_volume":0.0,
	"sfx_volume":0.0
}

# =====================================================
# READY
# =====================================================

func _ready():

	load_game()

# =====================================================
# SAVE GAME
# =====================================================

func save_game():

	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)

	if file == null:
		return

	file.store_var(save_data)

	file.close()

# =====================================================
# LOAD GAME
# =====================================================

func load_game():

	if !FileAccess.file_exists(SAVE_PATH):

		save_game()

		return

	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)

	if file == null:
		return

	save_data = file.get_var()

	file.close()

# =====================================================
# BEST SCORE
# =====================================================

func set_best_score(score : int):

	if score > save_data["best_score"]:

		save_data["best_score"] = score

		save_game()

func get_best_score():

	return save_data["best_score"]

# =====================================================
# HIGHEST ROUND
# =====================================================

func set_highest_round(round : int):

	if round > save_data["highest_round"]:

		save_data["highest_round"] = round

		save_game()

func get_highest_round():

	return save_data["highest_round"]

# =====================================================
# TOTAL KILLS
# =====================================================

func add_kill():

	save_data["total_kills"] += 1

	save_game()

func get_total_kills():

	return save_data["total_kills"]

# =====================================================
# PLAY TIME
# =====================================================

func add_play_time(seconds : float):

	save_data["play_time"] += seconds

	save_game()

func get_play_time():

	return save_data["play_time"]

# =====================================================
# MUSIC
# =====================================================

func set_music_volume(volume : float):

	save_data["music_volume"] = volume

	save_game()

func get_music_volume():

	return save_data["music_volume"]

# =====================================================
# SFX
# =====================================================

func set_sfx_volume(volume : float):

	save_data["sfx_volume"] = volume

	save_game()

func get_sfx_volume():

	return save_data["sfx_volume"]

# =====================================================
# RESET SAVE
# =====================================================

func reset_save():

	save_data = {

		"best_score":0,
		"highest_round":1,
		"total_kills":0,
		"play_time":0.0,

		"music_volume":0.0,
		"sfx_volume":0.0
	}

	save_game()
