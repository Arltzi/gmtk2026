extends Node

# Emits the exact hour and minute whenever the time changes so your UI can update
signal time_updated(hour: int, minute: int)
signal run_ended;

# 0.25 real second = 1 in-game minute
const START_TIME_SECONDS: float = 60.0
const TIME_PER_GEAR: float = 10.0

var deposited_gears: int = 0
var held_gears: int = 0

# Current loop
var starting_time := START_TIME_SECONDS
var time_remaining := START_TIME_SECONDS

var _timer: float = 0.0

func _ready() -> void:
	start_run()

func _process(delta: float) -> void:
	time_remaining -= delta

	if time_remaining <= 0.0:
		time_remaining = 0.0
		run_ended.emit()
		start_run()
		return

	_emit_time()

func deposit_gears(num_gears: int) -> void:
	deposited_gears += num_gears
	start_run()
	
func get_deposited_gears() -> int:
	return deposited_gears

func set_held_gears(num_gears: int) -> void:
	held_gears = num_gears

func get_held_gears() -> int:
	return held_gears

func start_run() -> void:
	starting_time = START_TIME_SECONDS + deposited_gears * TIME_PER_GEAR
	time_remaining = starting_time
	_emit_time()

func _emit_time() -> void:
	var progress := 1.0 - (time_remaining / starting_time)

	var total_minutes := int(progress * 60.0)

	var hour := 11 + (total_minutes / 60)
	var minute := total_minutes % 60

	time_updated.emit(hour, minute)
