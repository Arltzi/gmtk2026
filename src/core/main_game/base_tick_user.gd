class_name TickElement2D
extends Node2D

@export var ticks_per_signal: int = 0
signal run_interactive_beat

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	TickManager.tick.connect(_on_tick)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_tick(beat_count: int) -> void:
	if(beat_count % ticks_per_signal == 0):
		run_interactive_beat.emit()
		
