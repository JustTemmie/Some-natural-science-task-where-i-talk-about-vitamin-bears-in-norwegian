extends KinematicBody2D

var move = Vector2.ZERO
var look_vector = Vector2.ZERO
var player = null
var funny_variable
export var speed = 3

func _ready():
	look_vector = player.position - global_position

	
func _physics_process(delta):
	move = Vector2.ZERO
	
	move = move.move_toward(look_vector, delta)
	move = move.normalized() * speed
	funny_variable = move_and_collide(move)
	if funny_variable != null:
		queue_free()
