class_name Sun
extends Node2D

var time = 0

signal set_sun_rotation

var time_per_function:float  = 10

var orbital_angular_velocity: float = -2 * PI / (365.256363004 * 24 * 60 * 60)

var sun_function_1: Callable = func (t):
	return t / 2

var sun_function_2: Callable = func (t):
	return t / 3 + pow(sin(t * PI / 6), 2)
	
var sun_function_3: Callable = func(t):
	return pow(sin(t * PI / 7) + 1, 2) 
	
var sun_function_4: Callable = func(t):
	return log(sin(t * PI / 7) + 1.1)

var sun_function_5: Callable = func(t):
	return sin(t * PI / 10) + cos(t * PI)
	
var sun_function_6: Callable = func(t):
	return sin(t * PI / 8) + cos(1 + t * PI * 2 / 8) + sin(2 + t * PI * PI / 8) + sin(-1 + t * PI * 4 / 8)

var sun_functions = [sun_function_1, sun_function_2, sun_function_3, sun_function_4, sun_function_5, sun_function_6]

var sun_seed: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sun_seed = randi()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var current_sun_rotation: float = get_sun_rotation()
	set_sun_rotation.emit(current_sun_rotation)
	position = Vector2(sin(current_sun_rotation), -cos(current_sun_rotation))*250
	rotation = current_sun_rotation
	time += delta
	

func get_sun_rotation(time_from_current:float = 0) -> float:
	var current_cycle = (time + time_from_current) /  time_per_function
	if (current_cycle - floor(current_cycle)> 0.9):
		var t = (current_cycle - floor(current_cycle) - 0.9) * 5
		print(t)
		print(pseudo_random(sun_seed, floor(current_cycle)) % 6, pseudo_random(sun_seed, floor(current_cycle)+1) % 6)
		
		var current_sun_function = sun_functions[pseudo_random(sun_seed, floor(current_cycle)) % 6]
		var next_sun_function = sun_functions[pseudo_random(sun_seed, floor(current_cycle)+1) % 6]
		return lerp_angle(normalize_angle(current_sun_function, time + time_from_current), normalize_angle(next_sun_function, time + time_from_current), t)
	elif (current_cycle - floor(current_cycle) < 0.1):
		var t = (current_cycle - floor(current_cycle) + 0.1) * 5
		print(t)
		print(pseudo_random(sun_seed, floor(current_cycle-1)) % 6, pseudo_random(sun_seed, floor(current_cycle)) % 6)
		
		var current_sun_function = sun_functions[pseudo_random(sun_seed, floor(current_cycle)-1) % 6]
		var next_sun_function = sun_functions[pseudo_random(sun_seed, floor(current_cycle)) % 6]
		return lerp_angle(normalize_angle(current_sun_function, time + time_from_current), normalize_angle(next_sun_function, time + time_from_current), t)
	else:
		print(pseudo_random(sun_seed, floor(current_cycle)) % 6)
		var current_sun_function = sun_functions[pseudo_random(sun_seed, floor(current_cycle)) % 6]
		return normalize_angle(current_sun_function, time + time_from_current)

func normalize_angle(function: Callable, t: float):
	return fmod(function.call(t)*PI/3, PI * 2)

func pseudo_random(x: int, y: int) -> int:
	x = x * 3266489917 + 374761393;
	x = (x << 17) | (x >> 15);

	x += y * 3266489917;
	x *= 668265263;
	x ^= x >> 15;
	x *= 2246822519;
	x ^= x >> 13;
	x *= 3266489917;
	x ^= x >> 16;
	return x
	
static func lerp_angle(from, to, weight):
	var x: Vector2 = Vector2(sin(from), cos(from))
	var y: Vector2 = Vector2(sin(to), cos(to))
	var z: Vector2 = x * (1 - weight) + y * weight
	return atan2(z.y, z.x)
