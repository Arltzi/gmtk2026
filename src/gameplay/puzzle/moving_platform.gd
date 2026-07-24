extends Node2D

#adjust so every x amount of beats the action occurs

@onready var move_to_transform:Node2D = $MoveTo
@onready var platform = $Platform
@onready var tick_user: TickElement2D = $TickElement2D;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tick_user.run_interactive_beat.connect(move)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func move() ->void:
	var  tween = create_tween()
	tween.tween_property(platform, "global_position", move_to_transform.position,1.5)
	
