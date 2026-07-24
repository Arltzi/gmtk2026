extends PlatformerController2D
class_name Player

signal collectibles_updated(new_val: int)
signal collectibles_consumed(count: int)

var collectibles: int = 0:
  get:
    return collectibles
  set(value):
    collectibles = value
    collectibles_updated.emit(value)

func on_pickup(_collectible: Collectible) -> void:
  collectibles += 1
  pass
  
func reset_counter() -> void:
  collectibles_consumed.emit(collectibles)
  collectibles = 0
  pass
