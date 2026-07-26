extends Node

var music_player: AudioStreamPlayer
var looped_sfx_players: Dictionary = {}

func _ready() -> void:
	music_player = AudioStreamPlayer.new()
	music_player.bus = "Music" 
	add_child(music_player)

# --- MUSIC ---
func play_music(stream: AudioStream) -> void:
	if music_player.stream == stream and music_player.playing:
		return
	music_player.stream = stream
	music_player.play()

func stop_music() -> void:
	music_player.stop()

# --- ONE-SHOT SFX ---
func play_sfx(stream: AudioStream, volume_db: float = 0.0) -> void:
	var sfx_player = AudioStreamPlayer.new()
	sfx_player.stream = stream
	sfx_player.volume_db = volume_db
	sfx_player.bus = "SFX"
	add_child(sfx_player)
	
	sfx_player.finished.connect(sfx_player.queue_free)
	sfx_player.play()

# --- LOOPED SFX ---
func play_looped_sfx(sfx_name: String, stream: AudioStream, volume_db: float = 0.0) -> void:
	if looped_sfx_players.has(sfx_name):
		return 
		
	var loop_player = AudioStreamPlayer.new()
	loop_player.stream = stream
	loop_player.volume_db = volume_db
	loop_player.bus = "SFX"
	add_child(loop_player)
	
	looped_sfx_players[sfx_name] = loop_player
	loop_player.play()


func stop_looped_sfx(sfx_name: String) -> void:
	if looped_sfx_players.has(sfx_name):
		var player = looped_sfx_players[sfx_name]
		player.stop()
		player.queue_free()
		looped_sfx_players.erase(sfx_name)
