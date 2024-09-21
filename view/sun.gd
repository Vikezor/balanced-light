class_name Sun
extends Node2D

var time = 0

signal set_sun_rotation

var time_per_function:float  = 20

var orbital_angular_velocity: float = -2 * PI / (365.256363004 * 24 * 60 * 60)

var sun_function_1: Callable = func (t):
	return t

var sun_function_2: Callable = func (t):
	return t + pow(sin(t * PI / 3), 2)
	
var sun_function_3: Callable = func(t):
	return pow(sin(t * PI / 2.5) + 1, 2) 
	
var sun_function_4: Callable = func(t):
	return log(sin(t * PI / 3) + 1.1)

var sun_function_5: Callable = func(t):
	return sin(t * PI / 3) + cos(t * PI)
	
var sun_function_6: Callable = func(t):
	return sin(t * PI / 3) + cos(1 + t * PI * 2 / 3) + sin(2 + t * PI * PI) + sin(-1 + t * PI * 4 / 3)

var sun_functions = [sun_function_1, sun_function_2, sun_function_3, sun_function_4, sun_function_5, sun_function_6]

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
	

func get_sun_rotation(time_from_current:float = 0) -> float:
	return fmod(sun_functions[5].call(time + time_from_current)*PI/3, PI * 2)
