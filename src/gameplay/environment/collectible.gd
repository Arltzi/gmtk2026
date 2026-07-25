extends Node2D
class_name Collectible

#region FIELDS & PROPERTIES
# const, static, public, private
@export var spin_rate : float = 1
#endregion

#region COMPONENTS

#endregion

#region SIGNALS

#endregion

#region SUBCLASSES

#endregion

#region CALLBACKS

func _process(delta: float) -> void:
  #rotate(delta * spin_rate)
  pass
  
func _on_area_2d_body_entered(body: Node2D) -> void:
  if body is Player:
    call_deferred(&'pickup', body)
  pass
  
#endregion

#region FUNCTIONS
# static, public, protected, private

func pickup(player : Player) -> void:
  player.on_pickup(self)
  $Sprite2D.visible = false
  $Area2D/CollisionShape2D.disabled = true
  $GPUParticles2D.emitting = false
  $PointLight2D.enabled = false
  pass
  
#endregion
