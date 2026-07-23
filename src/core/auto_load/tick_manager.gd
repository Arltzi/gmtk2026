extends Node


@export var bpm: float = 120.0
var _time_per_beat: float = 0.0
var _time_since_last_tick: float = 0.0
var _beat_count: int = 0

signal tick(beat_count: int)

func _ready() -> void:
	_time_per_beat = 60.0 / bpm

func _process(delta: float) -> void:
	_time_since_last_tick += delta
	
	while _time_since_last_tick >= _time_per_beat:
		_time_since_last_tick -= _time_per_beat
		_beat_count += 1
		tick.emit(_beat_count)
		
