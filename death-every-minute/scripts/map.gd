extends Node2D

@onready var safe_zone = $SafeZone

func start_shrink(duration: float) -> void:
	# Create a tween to smoothly scale down the safe zone over the wave duration
	var tween = create_tween()
	# Shrinks down to 20% of its original size by the end of the timer
	tween.tween_property(safe_zone, "scale", Vector2(0.2, 0.2), duration)

func reset_map() -> void:
	# Reset the safe zone back to full size between waves
	safe_zone.scale = Vector2(1.0, 1.0)
