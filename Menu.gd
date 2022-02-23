extends Control

func _ready():
	OS.window_fullscreen = true


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("space") and Stats.can_start == 1:
		get_tree().change_scene("res://World.tscn")
