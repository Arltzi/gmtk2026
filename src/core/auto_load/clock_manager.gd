extends Node

# Emits the exact hour and minute whenever the time changes so your UI can update
signal time_updated(hour: int, minute: int)
signal game_over;

# 1 real second = 1 in-game minute
const REAL_SECONDS_PER_GAME_MINUTE = 1.0

# Start at 11:00 (11 hours * 60 minutes)
var total_game_minutes: int = 11 * 60
var _timer: float = 0.0

func _ready() -> void:
	# Defer the initial emit so other nodes have time to connect to the signal
	call_deferred("_emit_time")

func _process(delta: float) -> void:
	_timer += delta
	
	# Use 'while' to prevent drift and ensure we tick an in-game minute every real second
	while _timer >= REAL_SECONDS_PER_GAME_MINUTE:
		_timer -= REAL_SECONDS_PER_GAME_MINUTE
		total_game_minutes += 1
		_emit_time()

# Call this from your object's script when it gets picked up
func rewind_hours(hours_to_rewind: int) -> void:
	total_game_minutes -= (hours_to_rewind * 60)
	
	# Optional: Prevent time from going negative (before 00:00)
	if total_game_minutes < 0:
		total_game_minutes = 0
		# emit a game a over
		game_over.emit()
		
	_emit_time()

# Calculates the 24-hour clock values and pushes them to your game
func _emit_time() -> void:
	var hour = (total_game_minutes / 60) % 24
	var minute = total_game_minutes % 60
	
	time_updated.emit(hour, minute)
