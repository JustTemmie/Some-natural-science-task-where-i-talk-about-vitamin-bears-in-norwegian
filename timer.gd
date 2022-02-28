extends Node2D

var show = true

func _input(event):
	$Timer.start()

func _process(delta):
	if show:
		if Counter.id0 and Counter.id1 and Counter.id2 and Counter.id3 and Counter.id4 and Counter.id5:
			$UI/Control.show()
			show = false
		


func _on_Timer_timeout():
	get_tree().change_scene("res://Menu.tscn")


func _on_Button_pressed() -> void:
	$UI/Control.hide()
