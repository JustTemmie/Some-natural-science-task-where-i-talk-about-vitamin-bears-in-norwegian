extends Node2D


func _input(event):
	$Timer.start()

func _process(delta):
	print($Timer.time_left)


func _on_Timer_timeout():
	get_tree().change_scene("res://Menu.tscn")
