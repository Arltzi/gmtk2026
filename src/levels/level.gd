extends Node2D
class_name Level

#region FIELDS & PROPERTIES
# const, static, public, private

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

func complete_level() -> void:
  completed.emit()
  pass
  
func start_level() -> void:
  started.emit()
  pass
  
#endregion
