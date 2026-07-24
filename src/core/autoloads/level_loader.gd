extends Node

#region FIELDS & PROPERTIES
# const, static, public, private

var initial_level: PackedScene = preload('res://src/levels/level_01.tscn')
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

func _enter_tree() -> void:
  load_level(initial_level)
  
func load_level(scene: PackedScene) -> Level:
  var new_level: Level = scene.instantiate()
  add_child(new_level)
  
  new_level.completed.connect(on_level_completed)
  new_level.start_level()
  level_loaded.emit(new_level)
  return null
  
func on_level_completed(level: Level) -> void:
  level.queue_free()
  load_level(level.next_level_scene)
  pass
#endregion
