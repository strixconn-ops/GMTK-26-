extends Node

# Grab a reference to the Retry button using the exact path from your scene tree
@onready var retry_button = $CanvasLayer/VBoxContainer/Button

func _ready():
	# Make sure the mouse is visible so the player can actually click the button
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	# Connect the button's "pressed" signal to our custom function below
	retry_button.pressed.connect(_on_retry_pressed)

func _on_retry_pressed():
	# Load the main menu or main game scene. 
	# Make sure to change this path to wherever your actual game starts!
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_button_mouse_entered() -> void:
	pass # Replace with function body.
