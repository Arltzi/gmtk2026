extends TickElement2D

@export 
var moveTime : int = 0

@onready var move_to_transform:Node2D = $MoveTo
@onready var platform = $Platform

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_tick(beat_count: int) -> void:
	print("tick: " + str(beat_count))
	if(beat_count % moveTime):
		move();
		
func move() ->void:
	var  tween = create_tween()
	tween.tween_property(platform, "global_position", move_to_transform.position,1.5)
	
