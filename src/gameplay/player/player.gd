extends PlatformerController2D
class_name Player

signal gears_collected

var held_gears: int = 0
var overclock_modifiers = [
	{
		"speed": 0,
		"jump_height": 0,
	},
	{
		"speed": 0.05,
		"jump_height": 0.025,
	},
	{
		"speed": 0.1,
		"jump_height": 0.05,
	},
	{
		"speed": 0.2,
		"jump_height": 0.2,
	}
]

var collectibles: int = 0:
	get:
		return collectibles
	set(value):
		collectibles = value
		gears_collected.emit(value)

func _ready() -> void:
	super()
	ClockManager.start_run()

func on_pickup(_collectible: Collectible) -> void:
	collectibles += 1
	update_held_gears()
  
func reset_counter() -> void:
	gears_collected.emit(collectibles)
	collectibles = 0
	update_held_gears()

func update_held_gears() -> void:
	held_gears = min(collectibles, 3)
	ClockManager.set_held_gears(held_gears)
	maxSpeedLock = _maxSpeed * (1 + overclock_modifiers[held_gears].speed)
	timeToReachMaxSpeed = _timeToReachMaxSpeed * (1 - overclock_modifiers[held_gears].speed)
	jumpHeight = _jumpHeight * (1 + overclock_modifiers[held_gears].jump_height)
	gravityScale = _gravityScale * (1 - overclock_modifiers[held_gears].jump_height)


func _on_dropoff_deposit_gears() -> void:
	if collectibles <= 0:
		return
	ClockManager.deposit_gears(collectibles)
	held_gears = 0
	collectibles = 0
	update_held_gears()
	
	
