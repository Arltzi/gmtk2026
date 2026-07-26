extends Node

@onready var audio_stream_jump = $AudioStreamJump
@onready var audio_stream_hit_wall = $AudioStreamHitWall
@onready var audio_stream_stun_landing = $AudioStreamStunLanding
@onready var audio_stream_charge_jump = $AudioStreamChargeJump
@onready var audio_stream_landing = $AudioStreamLanding
@onready var audio_stream_switch_room = $AudioStreamSwitchRoom
@onready var audio_stream_special_rock = $AudioStreamSpecialRock

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
