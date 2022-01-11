extends Node2D

const GrassEffect = preload("res://Effects/GrassEffect.tscn")

# warning-ignore:unused_argument
func _on_Hurtbox_area_entered(area):
	create_grass_effect()
	queue_free()

func create_grass_effect():
	var grassEffect = GrassEffect.instance() # node = scene.instance()
	#var world = get_tree().current_scene
	get_parent().add_child(grassEffect)
	grassEffect.global_position = global_position

