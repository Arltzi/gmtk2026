extends Node
class_name LevelLoader

#region FIELDS & PROPERTIES
# const, static, public, private

#endregion

#region COMPONENTS

#endregion

#region SIGNALS

signal level_loaded(level: Level)

#endregion

#region SUBCLASSES

#endregion

#region CALLBACKS

#endregion

#region FUNCTIONS
# static, public, protected, private

func load_level(scene: PackedScene) -> Level:
  var new_level: Level = scene.instantiate()
  level_loaded.emit(new_level)
  return null
#endregion
