class_name TickElement2D
extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	TickManager.tick.connect(_on_tick)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_tick(beat_count: int) -> void:
	print("tick: " + str(beat_count))
