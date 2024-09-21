extends Node2D


var speed: float = -2 * PI / (24 * 60 * 60)
@export var thrust: float = 0
@export var thrust_strength = 3
@export var max_turning_speed = 6
var time = 0



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var thrust_control = Input.get_action_strength("right_thrust") - Input.get_action_strength("left_thrust")
	speed += thrust_control * thrust_strength * delta
	speed = clamp(speed, -max_turning_speed, max_turning_speed)
	$Diffuse.rotation += speed * delta
	time += delta


func _on_sun_set_sun_rotation(rot: float) -> void:
	$Shading.rotation = rot
