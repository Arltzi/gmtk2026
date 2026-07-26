extends Area2D
@onready var camera_2d : Camera2D = %Camera2D

func _on_area_entered(area):
	if area is Area2D:
		AudioManager.audio_stream_switch_room.play()
		camera_2d.position = self.global_position
