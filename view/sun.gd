class_name Sun
extends Node2D

var time = 0

signal set_sun_rotation

var orbital_angular_velocity: float = -2 * PI / (365.256363004 * 24 * 60 * 60)
@export var sun_function: Callable = func (t):
	return t * orbital_angular_velocity

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var current_sun_rotation: float = get_sun_rotation()
	set_sun_rotation.emit(current_sun_rotation)
	position = Vector2(sin(current_sun_rotation), -cos(current_sun_rotation))*250
	rotation = current_sun_rotation
	time += delta
	

func get_sun_rotation() -> float:
	return sun_function.call(time)
