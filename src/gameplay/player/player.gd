extends PlatformerController2D
class_name Player

signal collectibles_updated(new_val: int)
signal collectibles_consumed(count: int)

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
		collectibles_updated.emit(value)

func on_pickup(_collectible: Collectible) -> void:
	collectibles += 1
	update_held_gears()
	pass
  
func reset_counter() -> void:
	collectibles_consumed.emit(collectibles)
	collectibles = 0
	update_held_gears()
	pass

func update_held_gears() -> void:
	held_gears = min(collectibles, 3)
	maxSpeedLock = _maxSpeed * (1 + overclock_modifiers[held_gears].speed)
	timeToReachMaxSpeed = _timeToReachMaxSpeed * (1 - overclock_modifiers[held_gears].speed)
	jumpHeight = _jumpHeight * (1 + overclock_modifiers[held_gears].jump_height)
	gravityScale = _gravityScale * (1 - overclock_modifiers[held_gears].jump_height)
