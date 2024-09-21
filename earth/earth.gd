extends Node2D


var speed: float = -2 * PI / (24 * 60 * 60)
@export var thrust: float = 0
var orbital_angular_velocity: float = -2 * PI / (365.256363004 * 24 * 60 * 60)
@export var sun_function: Callable = func (time):
	return time * orbital_angular_velocity
var time = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	speed += thrust * delta
	$Diffuse.rotation += speed * delta
	$Shading.rotation = sun_function.call(time)
	time += delta
