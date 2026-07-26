extends Node2D
class_name Collectible

#region FIELDS & PROPERTIES
# const, static, public, private
@export var spin_rate : float = 1
var picked_up := false
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
	if picked_up:
		return
		
	if body is Player:
		picked_up = true
		$Area2D.set_deferred("monitoring", false)
		body.on_pickup(self)
		queue_free()
	pass
  
#endregion

#region FUNCTIONS
# static, public, protected, private

  
#endregion
