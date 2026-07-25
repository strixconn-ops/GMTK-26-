extends Control

# Grab references to your three buttons using their exact paths
@onready var start_button = $VBoxContainer/Button
@onready var options_button = $VBoxContainer/Button2
@onready var quit_button = $VBoxContainer/Button3

func _ready():
	# Make sure the mouse is visible so the player can click the buttons
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	# Connect the buttons' "pressed" signals to the custom functions below
	start_button.pressed.connect(_on_start_pressed)
	options_button.pressed.connect(_on_options_pressed)
	quit_button.pressed.connect(_on_quit_pressed)

func _on_start_pressed():
	# This loads your actual game. 
	# Looking at your FileSystem, "game_manager.tscn" seems like the main game controller.
	# If your main level is a different file, just update the path inside the quotes!
	get_tree().change_scene_to_file("res://scenes/game_manager.tscn")

func _on_options_pressed():
	# You can add logic here later to show an options menu or settings CanvasLayer
	print("Options button clicked! (Menu not built yet)")

func _on_quit_pressed():
	# This instantly closes the game application
	get_tree().quit()
