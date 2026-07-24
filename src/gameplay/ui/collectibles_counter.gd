extends Label
class_name CollectiblesCounter

#region FIELDS & PROPERTIES
# const, static, public, private

#endregion

#region COMPONENTS

#endregion

#region SIGNALS

#endregion

#region SUBCLASSES

#endregion

#region CALLBACKS

#endregion

#region FUNCTIONS
# static, public, protected, private

#endregion


func _on_player_collectibles_updated(new_val: int) -> void:
  text = "# of collectibles: %d" % new_val
  pass # Replace with function body.
