extends Control

func _ready():
	OS.window_fullscreen = true
	Counter.id0 = false
	Counter.id1 = false
	Counter.id2 = false
	Counter.id3 = false
	Counter.id4 = false
	Counter.id5 = false


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("space") and Stats.can_start == 1:
		get_tree().change_scene("res://World.tscn")
