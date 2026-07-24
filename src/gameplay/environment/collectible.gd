extends Node2D
class_name Collectible

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

func _on_area_2d_body_entered(body: Node2D) -> void:
  if body is Player:
    call_deferred(&'pickup', body)
  pass
  
#endregion

#region FUNCTIONS
# static, public, protected, private

func pickup(player : Player) -> void:
  $Sprite2D.visible = false
  $Area2D/CollisionShape2D.disabled = true
  player.on_pickup(self)
  pass
  
#endregion
