extends Node2D
class_name Level

#region FIELDS & PROPERTIES
# const, static, public, private

@export var next_level_path : String
var next_level_scene : PackedScene

#endregion

#region COMPONENTS

signal started
signal completed

#endregion

#region SIGNALS

#endregion

#region SUBCLASSES

#endregion

#region CALLBACKS

#endregion

#region FUNCTIONS
# static, public, protected, private

func start_level() -> void:
  next_level_scene = load(next_level_path)
  # validate next_level_scene here?
  started.emit()
  pass
  

func complete_level() -> void:
  completed.emit()
  pass
  
#endregion
