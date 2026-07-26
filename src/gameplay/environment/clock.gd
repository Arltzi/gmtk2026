extends Node2D # Change to Control if this is a UI element

# Drag your hand nodes into these slots in the Inspector
@export var hour_hand: Node2D
@export var minute_hand: Node2D
const LEVEL_MUSIC = preload("res://assets/audio/music/COUNTDOWN.wav")

func _ready() -> void:
	# Listen for the signal from the ClockManager autoload
	ClockManager.time_updated.connect(_update_clock_hands)
	AudioManager.play_music(LEVEL_MUSIC)


func _update_clock_hands(hour: int, minute: int) -> void:
	if not hour_hand or not minute_hand:
		push_warning("Clock hands are not assigned in the Inspector!")
		return
		
	# A full circle is 360 degrees. 
	# 360 / 60 minutes = 6 degrees per minute.
	minute_hand.rotation_degrees = minute * 6.0
	
	# 360 / 12 hours = 30 degrees per hour.
	# We convert to a 12-hour format, then add a fraction based on the minutes
	# so the hour hand sweeps smoothly between numbers (e.g., at 11:30 it sits right between 11 and 12).
	var hour_12 = hour % 12
	hour_hand.rotation_degrees = (hour_12 * 30.0) + ((minute / 60.0) * 30.0)
