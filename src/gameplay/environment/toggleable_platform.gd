@tool 
extends Node2D
class_name ToggleablePlatform

#region FIELDS & PROPERTIES
# const, static, public, private

#endregion

#region COMPONENTS
@onready var sprite : Sprite2D = $Sprite2D
@onready var shape : CollisionShape2D = $StaticBody2D/CollisionShape2D

@export var enabled : bool = true:
  get:
    return enabled
  set(value):
    enabled = value
    _set_enabled(value)
#endregion

#region SIGNALS

#endregion

#region SUBCLASSES

#endregion

#region CALLBACKS

#endregion

#region FUNCTIONS
# static, public, protected, private
func toggle_enabled() -> void:
  _set_enabled(not enabled)
  pass
  
func _set_enabled(enabled: bool) -> void:
  sprite.modulate = Color(1,1,1,1) if enabled else Color(1,1,1,0.5)
  shape.disabled = not enabled
  pass
#endregion
