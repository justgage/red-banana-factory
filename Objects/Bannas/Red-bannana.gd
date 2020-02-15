extends RigidBody2D

signal blow_up(body)

onready var area2d = $Area2D

func _on_Timer_timeout():
	var bodies = area2d.get_overlapping_bodies()
	for body in bodies:
		var blow_up_dir =  (body.position - position)* 20;
		if body is RigidBody2D:
			body.apply_central_impulse(blow_up_dir)
		
	emit_signal("blow_up", self)

func _on_FireTimer_timeout():
	$Particles2D.emitting = true
