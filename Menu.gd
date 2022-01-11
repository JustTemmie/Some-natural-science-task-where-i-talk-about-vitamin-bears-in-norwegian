extends Control

var player = "res://Player/Player.gd"

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("space") and Stats.can_start == 1:
		get_tree().change_scene("res://World.tscn")
